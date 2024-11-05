*** Settings ***
Documentation       Simple example using AppiumLibrary

Library             AppiumLibrary
Resource            ../Common/Commons.resource
Variables           Login_variables.py


*** Variables ***
${global_username}     
${global_password}     


*** Keywords ***
Login With Username And Password
    Wait Element And Fail If Not Found    ${login_txt_username}
    Input Text    xpath= ${login_txt_username}    ${global_username}
    Input Text    xpath= ${login_txt_password}    ${global_password}
    Wait Element And Fail If Not Found    ${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Wait Element And Fail If Not Found    ${login_dashboard_screen}

Login With Username Incorrect
    [Arguments]    ${username_incorrect}
    Wait Element And Fail If Not Found    ${login_txt_username}
    Input Text    xpath= ${login_txt_username}    ${username_incorrect}
    Input Text    xpath= ${login_txt_password}    ${global_password}
    Wait Element And Fail If Not Found    ${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Wait Element And Fail If Not Found    ${login_fail_error}

Login With Password Incorrect
    [Arguments]    ${password_incorrect}
    Wait Element And Fail If Not Found    ${login_txt_username}
    Input Text    xpath= ${login_txt_username}    ${global_username}
    Input Text    xpath= ${login_txt_password}    ${password_incorrect}
    Wait Element And Fail If Not Found    ${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Wait Element And Fail If Not Found    ${login_fail_error}

Login With Password Is Empty
    [Arguments]    ${password_incorrect}
    Wait Element And Fail If Not Found    ${login_txt_username}
    Input Text    xpath= ${login_txt_username}    ${global_username}
    Wait Element And Fail If Not Found    ${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Wait Element And Fail If Not Found    ${login_empty_error}

Login With Username Is Empty
    [Arguments]    ${password_incorrect}
    Wait Element And Fail If Not Found    ${login_txt_username}
    Input Text    xpath= ${login_txt_password}    ${global_password}
    Wait Element And Fail If Not Found    ${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Wait Element And Fail If Not Found    ${login_empty_error}
