*** Settings ***
Library         AppiumLibrary
Resource        ../Common/Commons.resource
Variables       LoginLogout_variables.py
Variables       ../Common/common_variable.py


*** Variables ***
${global_username}      
${global_password}      
${blank_password}       
${blank_username}       
${global_username_disable}       
${global_password_disable}       
${global_password_admin}       
${global_username_admin}       


*** Keywords ***
Login With Username And Password With User Account
    Wait Element And Fail If Not Found    id    ${login_txt_username}
    Input Text    id= ${login_txt_username}    ${global_username}
    Input Text    id= ${login_txt_password}    ${global_password}
    Wait Element And Fail If Not Found    id    ${login_btn_login}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_dashboard_screen}
Login With Username And Password With Admin Account
    Wait Element And Fail If Not Found    id    ${login_txt_username}
    Input Text    id= ${login_txt_username}    ${global_username_admin}
    Input Text    id= ${login_txt_password}    ${global_password_admin}
    Wait Element And Fail If Not Found    id    ${login_btn_login}
    Click Element    id=${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_dashboard_screen}
Login With Username Incorrect
    [Arguments]    ${username_incorrect}
    Wait Element And Fail If Not Found    id    ${login_txt_username}
    Input Text    id= ${login_txt_username}    ${username_incorrect}
    Input Text    id= ${login_txt_password}    ${global_password}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_fail_username_error_1}
    Wait Element And Fail If Not Found    xpath    ${login_fail_error_2}

Login With Password Incorrect
    [Arguments]    ${password_incorrect}
    Fill Input Text     id     ${login_txt_username}    ${global_username}
    Fill Input Text     id     ${login_txt_password}    ${password_incorrect}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_fail_password_error}
    Wait Element And Fail If Not Found    xpath    ${login_fail_error_2}

Login With Password Is Empty
    Fill Input Text     id    ${login_txt_username}    ${global_username}
    Fill Input Text     id    ${login_txt_password}    ${blank_password}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_empty_error}

Login With Account Disable
    Fill Input Text     id     ${login_txt_username}    ${global_username_disable}
    Fill Input Text     id     ${login_txt_password}    ${global_password_disable}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_fail_error_2}
    Wait Element And Fail If Not Found    xpath    ${login_fail_account_disable}

Login With Username Is Empty
    Fill Input Text     id     ${login_txt_username}    ${blank_username}
    Fill Input Text     id     ${login_txt_password}    ${global_password}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_empty_error}

Logout Account
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${logout_btn}
    Wait Element And Fail If Not Found    id    ${login_label_login}
