*** Settings ***
Library         AppiumLibrary
Library         .././PyLibrary/custom_keywords.py
Resource        ../Common/Commons.resource
Resource        ../Login/Login_Logout.resource
Variables       Account_variables.py


*** Variables ***
${path_in_android}          /storage/emulated/0/Download
${img_name}                 TEST.jpg
${path_in_android_img}      ${path_in_android}/${img_name}
${OLD_AVATAR_PATH}          ${EMPTY}
${FULL_SCREENSHOT}          ${EMPTY}
${CROPPED_PATH}             ${EMPTY}
${SSIM_THRESHOLD}           0.9
${username_before}          ${EMPTY}
${phone_before}             ${EMPTY}
${email_before}             ${EMPTY}
${noti_before}              ${EMPTY}
${department_before}        ${EMPTY}
${position_before}          ${EMPTY}
${edit_username}            FSI Tester
${edit_phone}               0988884546
${edit_email}               fsitest@gmail.com
${edit_position}            Admin
${blank_value}              ${EMPTY}
${phone_wrong_format}       bhtest
${email_wrong_format}       bhtest@


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
    Click On Element    xpath    ${download_more_option}
    Click On Element    xpath    ${download_option_brower}
    Click On Element    xpath    ${download_show_root_btn}
    Sleep    2
    Click On Element    xpath    ${download_btn_download}
    Click Element If Exists    com.google.android.documentsui:id/sub_menu_list
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
    Compare Text    Error    xpath    error_success    label
    Compare Text    Error    xpath    error_save_success    label

Click Element If Exists
    [Arguments]    ${ELEMENT_XPATH}
    ${result} =    Run Keyword And Ignore Error    Wait Until Element Is Visible    id=${ELEMENT_XPATH}
    IF    '${result}[0]' == 'PASS'    Click Element    id=${ELEMENT_XPATH}

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
    Update Media Store

Update Media Store
    Run Process
    ...    adb
    ...    shell
    ...    am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file://${path_in_android_img}
    ...    stdout=PIPE
    ...    stderr=PIPE

View Information Of User
    Wait Element And Fail If Not Found    id    ${account_txt_account_name}
    ${infor_username} =    Get Value From Input Box    id    ${account_txt_username}    text
    ${infor_accountName} =    Get Value From Input Box    id    ${account_txt_account_name}    text
    ${infor_phone} =    Get Value From Input Box    id    ${account_txt_phone_number}    text
    ${infor_email} =    Get Value From Input Box    id    ${account_txt_email}    text
    ${infor_create_bounds} =    Get Value From Input Box    id    ${account_txt_create_date}    bounds
    ${infor_email_bounds} =    Get Value From Input Box    id    ${account_txt_email}    bounds
    ${infor_accountName_bounds} =    Get Value From Input Box    id    ${account_btn_edit}    bounds
    ${infor_status} =    Get Value From Input Box    id    ${account_txt_status}    text
    IF    "${language}" == "VI"
        Should Be Equal As Strings    ${infor_status}    Đang Hoạt Động
    ELSE
        Should Be Equal As Strings    ${infor_status}    Active
    END
    Swipe Up    ${infor_create_bounds}    ${infor_accountName_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_role}
    ${infor_role} =    Get Value From Input Box    id    ${account_txt_role}    text
    Should Be Equal As Strings    ${infor_role}    ${role}
    ${infor_noti_bounds} =    Get Value From Input Box    id    ${account_select_receive_notification}    bounds
    ${infor_phone_bounds} =    Get Value From Input Box    id    ${account_txt_phone_number}    bounds
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
    Set Global Variable    ${username_before}    ${username_after_click_edit}
    Set Global Variable    ${phone_before}    ${phone_after_click_edit}
    Set Global Variable    ${email_before}    ${email_after_click_edit}
    Set Global Variable    ${noti_before}    ${accountEdit_select_receive_notification}
    IF    "${role}" == "Quản Trị Viên" or "${role}" == "Administrator"
        Wait Element And Fail If Not Found    id    ${accountEdit_select_position}
        ${position_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_select_position}    text
        Should Be Equal As Strings    ${position_after_click_edit}    ${infor_position}
        Wait Element And Fail If Not Found    id    ${accountEdit_txt_department}
        ${department_after_click_edit} =    Get Value From Input Box    id    ${accountEdit_txt_department}    text
        Should Be Equal As Strings    ${position_after_click_edit}    ${infor_department}
        Set Global Variable    ${department_before}    ${department_after_click_edit}
        Set Global Variable    ${position_before}    ${position_after_click_edit}
    END

Remove Image If Test Passed
    IF    "${TEST_STATUS}" == "PASS"
        End Record
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
    View Information Of User

Update Information With Admin Role - Test Setup
    Login With Username And Password With Admin Account
    Click On Element    id    ${bottom_menubar_account}
    Setup Language
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    View Information Of User

Remove Avatar - Test Teardown
    Remove Image If Test Passed
    Remove Image In Download Directory

Update Information Unsuccessfully
    View Information Of User
    Check Text Field Blank
    Check Wrong Format

Check Text Field Blank
    Fill Input Text    id    ${accountEdit_txt_username}    ${blank_value}
    Click On Element    id    ${accountEdit_btn_save}
    ${username_blank} =    Get Value From Input Box    id    ${error_username}    text
    Check Blank Message Error    ${username_blank}
    Fill Input Text    id    ${accountEdit_txt_email}    ${blank_value}
    Click On Element    id    ${accountEdit_btn_save}
    ${email_blank} =    Get Value From Input Box    id    ${error_email}    text
    Check Blank Message Error    ${email_blank}
    Fill Input Text    id    ${accountEdit_txt_phone_number}    ${blank_value}
    Click On Element    id    ${accountEdit_btn_save}
    ${phone_blank} =    Get Value From Input Box    id    ${error_phone}    text
    Check Blank Message Error    ${phone_blank}
    IF    "${role}" == "Quản Trị Viên" or "${role}" == "Administrator"
    ${position_blank} =    Get Value From Input Box    id    ${error_position}    text
    Check Blank Message Error    ${position_blank}
    END

Check Wrong Format
    Fill Input Text    id    ${accountEdit_txt_phone_number}    ${phone_wrong_format}
    Click On Element    id    ${accountEdit_btn_save}
    ${phone_wrong} =    Get Value From Input Box    id    ${error_phone}    text
    Check Format Message Error    ${phone_wrong}
    Fill Input Text    id    ${accountEdit_txt_email}    ${email_wrong_format}
    Click On Element    id    ${accountEdit_btn_save}
    ${email_wrong_format} =    Get Value From Input Box    id    ${error_email}    text
    Check Format Message Error    ${email_wrong_format}

Update Information Successfully
    View Information Of User
    Fill Input Text    id    ${accountEdit_txt_username}    ${edit_username}
    Fill Input Text    id    ${accountEdit_txt_phone_number}    ${edit_phone}
    Fill Input Text    id    ${accountEdit_txt_email}    ${edit_email}
    ${type_noti} =    Get Value From Input Box    id    ${accountEdit_select_receive_notification}    text
    Click On Element    id    ${accountEdit_select_receive_notification}
    ${chosen_noti} =    Random In Noti List    ${type_noti}
    Click On Element    xpath    //android.view.ViewGroup[@content-desc="${chosen_noti}"]
    Click On Element    id    ${accountEdit_btn_save}
    Compare Text    Error    xpath    error_success    label
    Compare Text    Error    xpath    error_save_success    label
    Sleep    2
    # Compare Before And After Save Edit
    Wait Element And Fail If Not Found    id    ${account_txt_account_name}
    ${infor_username} =    Get Value From Input Box    id    ${account_txt_username}    text
    Should Be Equal As Strings    ${edit_username}    ${infor_username}
    ${infor_phone} =    Get Value From Input Box    id    ${account_txt_phone_number}    text
    Should Be Equal As Strings    ${edit_phone}    ${infor_phone}
    ${infor_email} =    Get Value From Input Box    id    ${account_txt_email}    text
    Should Be Equal As Strings    ${edit_email}    ${infor_email}
    ${infor_create_bounds} =    Get Value From Input Box    id    ${account_txt_create_date}    bounds
    ${infor_accountName_bounds} =    Get Value From Input Box    id    ${account_btn_edit}    bounds
    Swipe Up    ${infor_create_bounds}    ${infor_accountName_bounds}
    Swipe Up    ${infor_create_bounds}    ${infor_accountName_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_role}
    ${infor_role} =    Get Value From Input Box    id    ${account_txt_role}    text
    Should Be Equal As Strings    ${infor_role}    ${role}
    ${infor_noti_bounds} =    Get Value From Input Box    id    ${account_select_receive_notification}    bounds
    ${infor_phone_bounds} =    Get Value From Input Box    id    ${account_txt_phone_number}    bounds
    ${infor_noti_text} =    Get Value From Input Box    id    ${account_select_receive_notification}    text
    Should Be Equal As Strings    ${chosen_noti}    ${infor_noti_text}
    Swipe Down    ${infor_noti_bounds}    ${infor_phone_bounds}
    # Compare Before And After Clicking Edit
    Wait Element And Fail If Not Found    id    ${account_txt_username}
    Click On Element    id    ${account_btn_edit}
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

Step To View Information
    Click On Element    id    ${bottom_menubar_account}
    Setup Language
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    Wait Element And Fail If Not Found    id    profile_btn_EditAccountInfo

Return Old Data Of Infor
    End Record
    Fill Input Text    id    ${accountEdit_txt_username}    ${username_before}
    Fill Input Text    id    ${accountEdit_txt_phone_number}    ${phone_before}
    Fill Input Text    id    ${accountEdit_txt_email}    ${email_before}
    ${type_noti} =    Get Value From Input Box    id    ${accountEdit_select_receive_notification}    text
    Click On Element    id    ${accountEdit_select_receive_notification}
    ${chosen_noti} =    Random In Noti List    ${type_noti}
    Click On Element    xpath    //android.view.ViewGroup[@content-desc="${chosen_noti}"]
    Click On Element    id    ${accountEdit_btn_save}

Log To
    ${name_id} =    Get Data From Json File    Name_ID
    ${text} =    Get Data From Json File    English
    ${type} =    Get Data From Json File    Type
    ${get_list_locator} =    Get All Value With Attribute    Login    ${name_id}
    ${get_list_text} =    Get All Value With Attribute    Login    ${text}
    ${get_list_type} =    Get All Value With Attribute    Login    ${type}
    @{LIST_LOCATOR} =    Evaluate    json.loads('''${get_list_locator}''')
    @{LIST_TEXT} =    Evaluate    json.loads('''${get_list_text}''')
    @{LIST_TYPE} =    Evaluate    json.loads('''${get_list_type}''')
    Log To Console    ${LIST_LOCATOR}
    FOR    ${index}    ${element}    IN ENUMERATE    @{LIST_LOCATOR}
        ${element_text} =    Set Variable    ${LIST_TEXT}[${index}]
        ${element_type} =    Set Variable    ${LIST_TYPE}[${index}]
        Log To Console    Processing: ${element} và ${element_text}
        Wait Element And Fail If Not Found    id    ${element}
        IF    "${element_type}"=="button"
            ${infor} =    Get Value From Input Box    id    ${element}    content-desc
            Should Be Equal As Strings    ${infor}    ${element_text}
        ELSE
            ${infor} =    Get Value From Input Box    id    ${element}    text
            Should Be Equal As Strings    ${infor}    ${element_text}
        END
    END
