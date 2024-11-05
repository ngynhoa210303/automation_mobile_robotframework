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
    Wait Until Element Is Visible    xpath=${login_txt_username}    10
    Input Text    xpath= ${login_txt_username}    ${global_username}
    Input Text    xpath= ${login_txt_password}    ${global_password}
    Wait Until Element Is Visible    xpath=${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Sleep    10
    Wait Until Element Is Visible    xpath=${login_dashboard_screen}    5
Login With Username Incorrect
    [Arguments]    ${username_incorrect}
    Wait Until Element Is Visible    xpath=${login_txt_username}    10
    Input Text    xpath= ${login_txt_username}    ${username_incorrect}
    Input Text    xpath= ${login_txt_password}    ${global_password}
    Wait Until Element Is Visible    xpath=${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Sleep    10
    Wait Until Element Is Visible    xpath=${login_fail_error}    5
Login With Password Incorrect
    [Arguments]    ${password_incorrect}
    Wait Until Element Is Visible    xpath=${login_txt_username}    10
    Input Text    xpath= ${login_txt_username}    ${global_username}
    Input Text    xpath= ${login_txt_password}    ${password_incorrect}
    Wait Until Element Is Visible    xpath=${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Sleep    10
    Wait Until Element Is Visible    xpath=${login_fail_error}    5
Login With Password Is Empty
    [Arguments]    ${password_incorrect}
    Wait Until Element Is Visible    xpath=${login_txt_username}    10
    Input Text    xpath= ${login_txt_username}    ${global_username}
    Wait Until Element Is Visible    xpath=${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Sleep    10
    Wait Until Element Is Visible    xpath=${login_empty_error}    5
Login With Username Is Empty
    [Arguments]    ${password_incorrect}
    Wait Until Element Is Visible    xpath=${login_txt_username}    10
    Input Text    xpath= ${login_txt_password}    ${global_password}
    Wait Until Element Is Visible    xpath=${login_btn_login}
    Click Element    xpath=${login_btn_login}
    Sleep    10
    Wait Until Element Is Visible    xpath=${login_empty_error}    5
