*** Settings ***
Library     AppiumLibrary
Library     .././PyLibrary/custom_keywords.py
Resource    ../Common/Commons.resource
Resource    ../Login/Login_Logout.resource
Resource    ../Account/Account.resource
Resource    ../Auth/Auth.resource
Library     Collections


*** Variables ***
${a}                        ${EMPTY}
@{LIST}                     @{EMPTY}
${START}                    0
${END}                      6
${username_incorrect}       BHtest
${password_incorrect}       BHtest@1234


*** Keywords ***
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
    Log To Console    @{LIST_LOCATOR}
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


Multilingual Check
    [Arguments]    ${language_check}
    Setup Language In Login Screen    ${language_check}
    Check Login Screen - Language
    Check Forgot Password Screen - Language
    Check Menu Screen - Language
    Check Information User - Language
    Check Change Password - Language
    Check TwoFA - Language

Check Login Screen - Language
    Get Label On Input Box    id    ${login_txt_username}
    Get Label On Input Box    id    ${login_txt_password}
    ${label_text_username} =    Get Value From Input Box    id    ${login_txt_username_inactive}    text
    Compare Text    Login    id    ${login_txt_username_inactive}    label
    Compare Text    Login    id    ${login_txt_password_inactive}    label
    Compare Text    Login    id    ${login_label_appName}    label
    Compare Text    Login    id    ${login_btn_forgotpass}    label
    Compare Text    Login    id    ${login_label_login}    label
    Compare Text    Login    id    ${login_btn_login}    button
    Login With Username Is Empty
    Compare Text    Error    xpath    error_blank_input    label
    Login With Password Is Empty
    Compare Text    Error    xpath    error_blank_input    label
    Login With Username Incorrect    ${username_incorrect}
    Compare Text    Error    xpath    error_not_found    label
    Login With Password Incorrect    ${password_incorrect}
    Compare Text    Error    xpath    error_password_incorrect    label
    Login With Account Disable
    Compare Text    Error    xpath    error_disable    label

Check Forgot Password Screen - Language
    Forgot Password Successfully
    Forgot Password With User Incorrect
    Compare Text    Login    id    ${login_label_appName}    label
    Compare Text    Forgot_Password    id    ${forgotPassword_btn_send}    button
    Compare Text    Forgot_Password    xpath    forgotPsw_input_Username-label-inactive    label
    Go Back

Check Menu Screen - Language
    Login With Username And Password With User Account
    Click On Element    id    ${bottom_menubar_account}
    Compare Text    Menu    id    ${bottom_menubar_dashboard}    label
    Compare Text    Menu    id    ${bottom_menubar_account}    label
    Compare Text    Menu    id    ${bottom_menubar_category}    label
    Compare Text    Menu    id    ${bottom_menubar_notification}    label
    Compare Text    Menu    id    ${account_btn_acc_information}    label
    Compare Text    Menu    id    ${menu_btn_changeLanguage}    label
    Compare Text    Menu    id    ${menu_btn_logout}    label

Check Information User - Language
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    Compare Text    View_Account    id    ${account_btn_edit}    button
    Compare Text    View_Account    id    profile_text_AccountInformation    label
    Compare Text    View_Account    id    ${account_btn_change_password}    button
    Compare Text    View_Account    id    profile_input_DisplayName-label-inactive    label
    Compare Text    View_Account    id    profile_input_Username-label-inactive    label
    Compare Text    View_Account    id    profile_input_Phone-label-inactive    label
    Compare Text    View_Account    id    profile_input_Email-label-inactive    label
    Compare Text    View_Account    id    profile_input_Status-label-inactive    label
    ${infor_create_bounds} =    Get Value From Input Box    id    ${account_txt_create_date}    bounds
    ${infor_accountName_bounds} =    Get Value From Input Box    id    ${account_btn_edit}    bounds
    Swipe Up    ${infor_create_bounds}    ${infor_accountName_bounds}
    Compare Text    View_Account    id    profile_text_CreationDate-label-inactive    label
    Compare Text    View_Account    id    profile_text_UpdateDate-label-inactive    label
    IF    "${role}" == "Quản Trị Viên" or "${role}" == "Administrator"
        Compare Text    View_Account    id    profile_input_Position-label-inactive    label
    END
    Compare Text    View_Account    id    profile_text_Notifications-label-inactive    label
    ${infor_noti_bounds} =    Get Value From Input Box    id    ${account_select_receive_notification}    bounds
    ${infor_phone_bounds} =    Get Value From Input Box    id    ${account_txt_phone_number}    bounds
    Swipe Down    ${infor_noti_bounds}    ${infor_phone_bounds}
    Wait Element And Fail If Not Found    id    ${account_txt_username}
    Click On Element    id    ${account_btn_edit}
    Compare Text    Edit_Account    id    editProfile_input_DisplayName-label-inactive    label
    Compare Text    Edit_Account    id    editProfile_input_Phone-label-inactive    label
    Compare Text    Edit_Account    id    editProfile_input_Email-label-inactive    label
    IF    "${role}" == "Quản Trị Viên" or "${role}" == "Administrator"
        Compare Text    View_Account    id    profile_input_Position-label-inactive    label
    END
    Compare Text    Edit_Account    id    editProfile_select_Notifications-label-inactive    label
    Compare Text    Edit_Account    id    editProfile_btn_Save    button
    Check Text Field Blank
    Check Wrong Format
    Go Back

Check Change Password - Language
    Click On Element    id    ${changePassword_btn_changePassword}
    Compare Text    Change_Password    id    ${changePassword_error_condition_pass_1}    label
    Compare Text    Change_Password    id    ${changePassword_error_condition_pass_2}    label
    Compare Text    Change_Password    id    ${changePassword_error_condition_pass_3}    label
    Change Password With Text Field Empty
    Change Password With Current Password Wrong
    Change Password With New Password Diffirent Confirm Password
    Change Password With New Password Wrong Format
    Compare Text    Change_Password    id    ${changePassword_btn_save}    button
    Go Back

Check TwoFA - Language
    Click On Element    id    ${account_switch_2FA}
    Compare Text    TFA    id    ${tfa_modal_txt_enable2FA}    label
    Compare Text    TFA    xpath    tfa_text_getVerified    label
    Compare Text    TFA    xpath    tfa_radio_text_email    label
    Compare Text    TFA    xpath    tfa_radio_text_phone    label
    Compare Text    TFA    id    ${tfaModal_btn_continue}    button
    Click On Element    id    ${tfa_radio_email}
    Click On Element    id    ${tfaModal_btn_continue}
    Compare Text    TFA    id    ${tfa_txt_emailInstruction}    label
    Click On Element    id    ${tfa_btn_verify}
    ${countdown} =    Get Value From Input Box    id    app_text_Countdown    text
    Log    Giá trị countdown hiện tại: ${countdown}
    Should Match Regexp    ${countdown}    ^\\d{2}:\\d{2}$ 
    Click On Element    xpath    ${btn_exit_modal}
    Sleep    2
    Go Back
    Click On Element    id    ${logout_btn}