*** Settings ***
Library         AppiumLibrary
Resource        ../Common/Commons.resource
Resource        ../Login/Login_Logout.resource
Variables       Auth_variables.py

*** Variables ***
${global_usercorrect}
${global_userincorrect}
*** Keywords ***
Forgot Password Successfully 
    Click On Element    xpath    ${forgotPassword_btn_forgotPassword}
    Wait Element And Fail If Not Found    id    ${forgotPassword_tilte_forgot}
    Wait Element And Fail If Not Found    id    ${forgotPassword_txt_accountName}
    Fill Input Text     id    ${forgotPassword_txt_accountName}    ${global_usercorrect}
    Click On Element    id    ${forgotPassword_btn_send}
    Wait Element And Fail If Not Found    id    ${forgotPassword_text_send_success}
    Click On Element   id    ${forgotPassword_btn_done}
    Wait Element And Fail If Not Found    id    ${forgotPassword_label_login}
Forgot Password With User Incorrect 
    Click On Element    xpath    ${forgotPassword_btn_forgotPassword}
    Wait Element And Fail If Not Found    id    ${forgotPassword_tilte_forgot}
    Wait Element And Fail If Not Found    id    ${forgotPassword_txt_accountName}
    Fill Input Text     id    ${forgotPassword_txt_accountName}    ${global_userincorrect}
    Click On Element    id    ${forgotPassword_btn_send}
    Wait Element And Fail If Not Found    xpath    ${forgotPassword_fail_error_1}
    Wait Element And Fail If Not Found    xpath    ${forgotPassword_fail_error_2}