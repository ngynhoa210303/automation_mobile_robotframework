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
    [Arguments]    ${username_correct}=${global_username}    ${password_correct}=${global_password}
     IF    "${language}" == "VI"
        Set Global Variable    ${role}    Giám Sát Viên
    ELSE
        Set Global Variable    ${role}    Monitor 
    END    
    Wait Element And Fail If Not Found    id    ${login_txt_username}
    Fill Input Text    id    ${login_txt_username}    ${username_correct}
    Fill Input Text    id    ${login_txt_password}    ${password_correct}
    Wait Element And Fail If Not Found    id    ${login_btn_login}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_dashboard_screen}

Login With Username And Password With Admin Account
    IF    "${language}" == "VI"
        Set Global Variable    ${role}    Quản Trị Viên
    ELSE
        Set Global Variable    ${role}    Administrator
    END    
    Wait Element And Fail If Not Found    id    ${login_txt_username}
    Fill Input Text    id    ${login_txt_username}    ${global_username_admin}
    Fill Input Text    id    ${login_txt_password}    ${global_password_admin}
    Wait Element And Fail If Not Found    id    ${login_btn_login}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    xpath    ${login_dashboard_screen}

Login With Username Incorrect
    [Arguments]    ${username_incorrect}
    Wait Element And Fail If Not Found    id    ${login_txt_username}
    Fill Input Text    id    ${login_txt_username}    ${username_incorrect}
    Fill Input Text    id    ${login_txt_password}    ${global_password}
    Click On Element    id    ${login_btn_login}
    IF    "${language}"=="VI"
        Wait Element And Fail If Not Found    xpath    ${login_fail_username_error_1}
        Wait Element And Fail If Not Found    xpath    ${login_fail_error_2}
    ELSE
        Wait Element And Fail If Not Found    xpath    ${login_fail_error_2_en}
        Wait Element And Fail If Not Found    xpath    ${login_fail_username_error_1_en}
    END

Login With Password Incorrect
    [Arguments]    ${password_incorrect}
    Fill Input Text    id    ${login_txt_username}    ${global_username}
    Fill Input Text    id    ${login_txt_password}    ${password_incorrect}
    Click On Element    id    ${login_btn_login}
    IF    "${language}"=="VI"
        Wait Element And Fail If Not Found    xpath    ${login_fail_password_error}
        Wait Element And Fail If Not Found    xpath    ${login_fail_error_2}
    ELSE
        Wait Element And Fail If Not Found    xpath    ${login_fail_error_2_en}
        Wait Element And Fail If Not Found    xpath    ${login_fail_password_error_en}
    END

Login With Password Is Empty
    Fill Input Text    id    ${login_txt_username}    ${global_username}
    Fill Input Text    id    ${login_txt_password}    ${blank_password}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    id    ${login_empty_password_error}

Login With Account Disable
    Fill Input Text    id    ${login_txt_username}    ${global_username_disable}
    Fill Input Text    id    ${login_txt_password}    ${global_password_disable}
    Click On Element    id    ${login_btn_login}
    IF    "${language}"=="VI"
        Wait Element And Fail If Not Found    xpath    ${login_fail_error_2}
        Wait Element And Fail If Not Found    xpath    ${login_fail_account_disable}
    ELSE
        Wait Element And Fail If Not Found    xpath    ${login_fail_error_2_en}
        Wait Element And Fail If Not Found    xpath    ${login_fail_account_disable_en}
    END

Login With Username Is Empty
    Fill Input Text    id    ${login_txt_username}    ${blank_username}
    Fill Input Text    id    ${login_txt_password}    ${global_password}
    Click On Element    id    ${login_btn_login}
    Wait Element And Fail If Not Found    id    ${login_empty_username_error}

Logout Account
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${logout_btn}
    Wait Element And Fail If Not Found    id    ${login_label_login}
