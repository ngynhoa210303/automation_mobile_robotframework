*** Settings ***
Library  AppiumLibrary
Resource          ../../Resource/Login/Login_Logout.resource
Resource          ../../Resource/Common/Commons.resource
Suite Setup         FSI Sys - Suite Setup
Suite Teardown      FSI Sys - Suite Teardown
Test Setup          Create Test Record
Test Teardown       End Record
*** Variables ***
${username_incorrect}    BHtest
${password_incorrect}   BHtest@1234
*** Test Cases ***
Check Login With Password Is Empty
    [Tags]    Medium    TC-1
    Login With Password Is Empty  
Check Login With Username Is Empty
    [Tags]    Medium    TC-2
    Login With Username Is Empty  
Check Login With Username Incorrect And Password Correct
    [Tags]    Medium    TC-3
    Login With Username Incorrect    ${username_incorrect}
Check Login With Password Incorrect And Username Correct
    [Tags]    Medium    TC-4
    Login With Password Incorrect    ${password_incorrect}
Check Login With Account Disable
    [Tags]    Critical    TC-7
    Login With Account Disable
Check Login And Logout Successfully With Role User
    [Tags]    Critical    TC-5    TC-8.1
    Login With Username And Password With User Account
    Logout Account
Check Login And Logout Successfully With Role Admin
    [Tags]    Critical    TC-6    TC-8.2
    Login With Username And Password With Admin Account
    Logout Account
    
