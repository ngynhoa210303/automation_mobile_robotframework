*** Settings ***
Library         AppiumLibrary
Resource        ../Common/Commons.resource
Resource        ../Login/Login_Logout.resource
Variables       Auth_variables.py


*** Variables ***
${global_usercorrect}                           ${EMPTY}
${global_userincorrect}                         ${EMPTY}
${global_username_change}                       ${EMPTY}
${global_password_change}                       ${EMPTY}
${global_new_password}                          BHSm@1234567
${wrongPassword_geaterthan_15_characters}       BHSmpl@123434346
${wrongPassword_lessthan_10_characters}         Bh@2
${wrongPassword_not_contain_lowercase}          BHS@1234567
${wrongPassword_not_contain_uppercase}          bhs@1234567
${wrongPassword_lessthan_10_characters}         Bh@2
${wrongPassword_contain_space}                  BH @1245678
${wrongPassword_contain_accountName}            ${EMPTY}
${wrongPassword_contain_email}                  ${EMPTY}
${wrongPassword_contain_userName}               ${EMPTY}


*** Keywords ***
Forgot Password Successfully
    Click On Element    id    ${forgotPassword_btn_forgotPassword}
    Wait Element And Fail If Not Found    id    ${forgotPassword_tilte_forgot}
    Wait Element And Fail If Not Found    id    ${forgotPassword_txt_accountName}
    Fill Input Text    id    ${forgotPassword_txt_accountName}    ${global_usercorrect}
    Click On Element    id    ${forgotPassword_btn_send}
    Wait Element And Fail If Not Found    id    ${forgotPassword_text_send_success}
    Click On Element    id    ${forgotPassword_btn_done}
    Wait Element And Fail If Not Found    id    ${forgotPassword_label_login}

Forgot Password With User Incorrect
    Click On Element    id    ${forgotPassword_btn_forgotPassword}
    Wait Element And Fail If Not Found    id    ${forgotPassword_tilte_forgot}
    Wait Element And Fail If Not Found    id    ${forgotPassword_txt_accountName}
    Fill Input Text    id    ${forgotPassword_txt_accountName}    ${global_userincorrect}
    Click On Element    id    ${forgotPassword_btn_send}
    Compare Text    Error    xpath    error_an_error_occurred    label
    Compare Text    Error    xpath    error_not_found    label

Change Password Successfully
    Common Check Password    ${global_password_change}    ${global_new_password}    ${global_new_password}
    Compare Text    Error    xpath    error_changePw_success    label

Change Password - Teardown
    End Record
    Login With Username And Password With User Account    ${global_username_change}    ${global_new_password}
    Step To Change Password
    Common Check Password    ${global_new_password}    ${global_password_change}    ${global_password_change}
    Login With Username And Password With User Account    ${global_username_change}    ${global_password_change}

Change Password - SetUp
    Login With Username And Password With User Account    ${global_username_change}    ${global_password_change}

Change Password With Text Field Empty
    Click On Element    id    ${changePassword_btn_save}
    ${error_current} =    Get Value From Input Box    id    ${changePassword_error_empty_currentpass}    text
    Check Blank Message Error    ${error_current}
    ${error_current} =    Get Value From Input Box    id    ${changePassword_error_empty_newpass}    text
    Check Blank Message Error    ${error_current}
    ${error_current} =    Get Value From Input Box    id    ${changePassword_error_empty_confirmpass}    text
    Check Blank Message Error    ${error_current}

Change Password With Current Password Wrong
    Common Check Password    ${global_new_password}    ${global_password_change}    ${global_password_change}
    Compare Text    Error    xpath    error_currentpass_incorrect    label

Change Password With New Password Diffirent Confirm Password
    Common Check Password    ${global_password_change}    ${global_new_password}    ${global_password_change}
    Compare Text    Error    id    changePsw_text_ConfirmPassword    label

Common Check Password
    [Arguments]    ${fg_current_password}    ${fg_new_password}    ${fg_confirm_password}
    Fill Input Text    id    ${changePassword_txt_currentPassword}    ${fg_current_password}
    Fill Input Text    id    ${changePassword_txt_newPassword}    ${fg_new_password}
    Fill Input Text    id    ${changePassword_txt_confirmPassword}    ${fg_confirm_password}
    Click On Element    id    ${changePassword_btn_save}

Step To Change Password
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
    ${infor_username} =    Get Value From Input Box    id    ${account_txt_username}    text
    ${get_username} =    Set Variable    ${infor_username}[0:3]
    Set Global Variable    ${wrongPassword_contain_accountName}    ${get_username}Bh@1245
    ${infor_accountName} =    Get Value From Input Box    id    ${account_txt_account_name}    text
    ${get_accountname} =    Set Variable    ${infor_accountName}[0:3]
    Set Global Variable    ${wrongPassword_contain_email}    ${get_accountname}Bh@124567
    ${infor_email} =    Get Value From Input Box    id    ${account_txt_email}    text
    ${get_email} =    Set Variable    ${infor_email}[0:3]
    Set Global Variable    ${wrongPassword_contain_userName}    ${get_email}Bh@124567
    Click On Element    id    ${changePassword_btn_changePassword}

Change Password With New Password Wrong Format
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_geaterthan_15_characters}
    ...    ${wrongPassword_geaterthan_15_characters}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_lessthan_10_characters}
    ...    ${wrongPassword_lessthan_10_characters}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_contain_space}
    ...    ${wrongPassword_contain_space}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_contain_userName}
    ...    ${wrongPassword_contain_userName}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_contain_email}
    ...    ${wrongPassword_contain_email}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_not_contain_lowercase}
    ...    ${wrongPassword_not_contain_lowercase}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
    Common Check Password
    ...    ${global_password_change}
    ...    ${wrongPassword_not_contain_uppercase}
    ...    ${wrongPassword_not_contain_uppercase}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_1}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_2}
    Wait Element And Fail If Not Found    id    ${changePassword_error_condition_pass_3}
