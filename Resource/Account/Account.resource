*** Settings ***
Library         AppiumLibrary
Library         Process.py
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


*** Keywords ***
Upload Avatar
    # Wait Element And Fail If Not Found And Click Element    id    ${bottom_menubar_dashboard}
    # Wait Element And Fail If Not Found And Click Element    id    ${account_btn_acc_information}
    # # ${project_path} =    Path To Project
    # # ${path} =    Set Variable    ${project_path}/utils/lolo.png
    # # Crop Image Directly    xpath=${view_image_before_click_edit}    ${path}
    # Wait Element And Fail If Not Found And Click Element    id    ${account_btn_edit}
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
    Click On Element    xpath    ${accountEdit_btn_save}

Check File Exists
    [Arguments]    ${file_path}
    ${result} =    Run Process    adb    shell    ls    ${file_path}    stdout=PIPE    stderr=PIPE
    IF    '${result.stdout}' == ''    Fail    File not found: ${file_path}
    Log To Console    File successfully found: ${file_path}

Remove Image - Test Teardown
    Run Process    adb    shell    rm    ${path_in_android_img}
    Log To Console    Image removed successfully.

Upload Image to Download Directory
    ${project_path} =    Path To Project
    ${project_pc} =    Set Variable    ${project_path}/utils/${img_name}
    Run Process    adb    push    ${project_pc}    ${path_in_android_img}    stdout=PIPE    stderr=PIPE

# Update Image - Test Setup
#    Login With Username And Password With User Account

View Information Of User
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    Wait Element And Fail If Not Found    id    ${account_txt_account_name}
    ${infor_username} =    Get Element Attribute    id=${account_txt_username}    text
    ${infor_accountName} =    Get Element Attribute    id=${account_txt_account_name}    text
    ${infor_phone} =    Get Element Attribute    id=${account_txt_phone_number}    text
    ${infor_email} =    Get Element Attribute    id=${account_txt_email}    text
    ${infor_email_bounds} =    Get Element Attribute    id=${account_txt_update_date}    bounds
    ${infor_accountName_bounds} =    Get Element Attribute    id=${account_txt_account_name}    bounds
    Swipe Up    ${infor_email_bounds}    ${infor_accountName_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_role}
    ${infor_role} =    Get Element Attribute    id=${account_txt_role}    text
    ${infor_PHONE_bounds} =    Get Element Attribute    id=${account_txt_phone_number}    bounds
    ${infor_NOTI_bounds} =    Get Element Attribute    id=${account_select_receive_notification}    bounds
    Swipe Down    ${infor_NOTI_bounds}    ${infor_PHONE_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_username}
    ${infor} =    Get Element Attribute    id=${account_txt_username}    text
    Log To Console    ${infor}
    # ${infor_notification}=    Get Element Attribute    id=${account_select_receive_notification}    text
    # Should Be Equal As Strings    ${infor_role}    Giám Sát Viên

# Crop Image Directly
#    [Arguments]    ${locator}    ${output_path}
#    Capture Man    ${locator}    ${output_path}

Update Information - Test Setup
    Login With Username And Password With User Account
    View Information Of User

