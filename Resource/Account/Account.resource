*** Settings ***
Library         AppiumLibrary
Library         ../../.venv/lib/site-packages/robot/libraries/String.py
Resource        ../Common/Commons.resource
Resource        ../Login/Login_Logout.resource
Resource        ../Login/Login_Logout.resource
Variables       Account_variables.py
Variables       ../Common/common_variable.py


*** Variables ***
${path_in_android}          /sdcard/Download
${img_name}                 TEST.jpg
${path_in_android_img}      ${path_in_android}/${img_name}
${admin_role}               Quản Trị Viên
${monitor_role}             Giám Sát Viên
${OLD_AVATAR_PATH}          ${EMPTY}
${FULL_SCREENSHOT}          ${EMPTY}
${CROPPED_PATH}             ${EMPTY}
${SSIM_THRESHOLD}           0.9


*** Keywords ***
Upload Avatar
    ${project_path} =    Path To Project
    Set Global Variable    ${FULL_SCREENSHOT}    ${project_path}/Screenshots/full_screenshot.png
    Set Global Variable    ${OLD_AVATAR_PATH}    ${project_path}/Screenshots/old-avatar.png
    Set Global Variable    ${CROPPED_PATH}    ${project_path}/Screenshots/cropped-avatar.png
    Login With Username And Password With User Account
    Click On Element    id    ${bottom_menubar_account}
    Setup Language
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    Wait Element And Fail If Not Found    id    profile_btn_EditAccountInfo
    Click On Element    id    ${account_btn_edit}
    Wait Element And Fail If Not Found    id    ${accountEdit_btn_save}
    ${infor_image_bounds} =    Get Value From Input Box    xpath    ${accountEdit_image_view}    bounds
    Capture Element Of Page    ${infor_image_bounds}    ${FULL_SCREENSHOT}    ${OLD_AVATAR_PATH}
    Upload Image to Download Directory
    Check File Exists    ${path_in_android_img}
    Click On Element    id    ${accountEdit_image_avatar}
    Click On Element    xpath    ${download_choose_image}
    Click On Element    xpath    ${download_show_root_btn}
    Click On Element    xpath    ${download_btn_download}
    Click On Element
    ...    xpath
    ...    //android.widget.TextView[@resource-id="android:id/title" and @text="${img_name}"]
    Click On Element    xpath    ${download_crop_img}
    Sleep    5
    ${infor_image_bounds_after} =    Get Value From Input Box    xpath    ${accountEdit_image_view}    bounds
    Capture Element Of Page    ${infor_image_bounds_after}    ${FULL_SCREENSHOT}    ${CROPPED_PATH}
    ${result} =    Compare Images    ${OLD_AVATAR_PATH}    ${CROPPED_PATH}    ${SSIM_THRESHOLD}
    Should Be True    ${result}    Avatar should have changed
    Click On Element    id    ${accountEdit_btn_save}
    Wait Element And Fail If Not Found    xpath    ${error_success_1}
    Wait Element And Fail If Not Found    xpath    ${error_success_2}

Check File Exists
    [Arguments]    ${file_path}
    ${result} =    Run Process    adb    shell    ls    ${file_path}    stdout=PIPE    stderr=PIPE
    IF    '${result.stdout}' == ''    Fail    File not found: ${file_path}

Remove Image In Download Directory
    Run Process    adb    shell    rm    ${path_in_android_img}
    Log To Console    Image removed successfully.

Upload Image to Download Directory
    ${project_path} =    Path To Project
    ${project_pc} =    Set Variable    ${project_path}/utils/${img_name}
    Run Process    adb    push    ${project_pc}    ${path_in_android_img}    stdout=PIPE    stderr=PIPE

View Information Of User
    [Arguments]    ${role}
    Wait Element And Fail If Not Found    id    ${account_txt_account_name}
    ${infor_username} =    Get Value From Input Box    id    ${account_txt_username}    text
    ${infor_accountName} =    Get Value From Input Box    id    ${account_txt_account_name}    text
    ${infor_phone} =    Get Value From Input Box    id    ${account_txt_phone_number}    text
    ${infor_email} =    Get Value From Input Box    id    ${account_txt_email}    text
    ${infor_email_bounds} =    Get Value From Input Box    id    ${account_txt_update_date}    bounds
    ${infor_accountName_bounds} =    Get Value From Input Box    id    ${account_txt_account_name}    bounds
    ${infor_status} =    Get Value From Input Box    id    ${account_txt_status}    text
    Should Be Equal As Strings    ${infor_status}    Đang Hoạt Động
    Swipe Up    ${infor_email_bounds}    ${infor_accountName_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_role}
    ${infor_role} =    Get Value From Input Box    id    ${account_txt_role}    text
    Should Be Equal As Strings    ${infor_role}    ${role}
    ${infor_phone_bounds} =    Get Value From Input Box    id    ${account_txt_phone_number}    bounds
    ${infor_noti_bounds} =    Get Value From Input Box    id    ${account_select_receive_notification}    bounds
    ${infor_noti_text} =    Get Value From Input Box    id    ${account_select_receive_notification}    text
    ${infor_position} =    Get Value From Input Box    id    ${account_select_position}    text
    ${infor_department} =    Get Value From Input Box    id    ${account_txt_department}    text
    Swipe Down    ${infor_noti_bounds}    ${infor_phone_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_username}
    Click On Element    id    ${account_btn_edit}
    Wait Element And Fail If Not Found    id    ${accountEdit_btn_save}
    # Compare Before And After Clicking Edit
    ${username_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_txt_username}    text
    Should Be Equal As Strings    ${username_after_click_edit}    ${infor_username}
    ${phone_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_txt_phone_number}    text
    Should Be Equal As Strings    ${phone_after_click_edit}    ${infor_phone}
    ${email_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_txt_email}    text
    Should Be Equal As Strings    ${email_after_click_edit}    ${infor_email}
    ${noti_after_click_edit} =    Get Value From Input Box
    ...    id
    ...    ${accountEdit_select_receive_notification}
    ...    text
    Should Be Equal As Strings    ${noti_after_click_edit}    ${infor_noti_text}
    IF    "${role}" == "Quản Trị Viên"
        Wait Element And Fail If Not Found    id    ${accountEdit_select_position}
        ${position_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_select_position}    text
        Should Be Equal As Strings    ${position_after_click_edit}    ${infor_position}
        Wait Element And Fail If Not Found    id    ${accountEdit_txt_department}
        ${department_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_txt_department}    text
        Should Be Equal As Strings    ${position_after_click_edit}    ${infor_department}
    END

Remove Image If Test Passed
    IF    "${TEST_STATUS}" == "PASS"
        ${path} =    PathToProject
        Sleep    2
        Click On Element    id    ${account_btn_edit}
        Click On Element    xpath    ${account_delete_image}
        Click On Element    id    ${accountEdit_btn_save}
        Remove File    ${FULL_SCREENSHOT}
        Remove File    ${OLD_AVATAR_PATH}
        Remove File    ${CROPPED_PATH}
    END

Update Information With User Role - Test Setup
    Login With Username And Password With User Account
    Click On Element    id    ${bottom_menubar_account}
    Setup Language
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    View Information Of User    ${monitor_role}

Update Information With Admin Role - Test Setup
    Login With Username And Password With Admin Account
    Click On Element    id    ${bottom_menubar_account}
    Setup Language
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    View Information Of User    ${admin_role}

Remove Avatar - Test Teardown
    Remove Image If Test Passed
    Remove Image In Download Directory
