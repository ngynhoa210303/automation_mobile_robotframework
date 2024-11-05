*** Settings ***
Library  AppiumLibrary
Library    FlaUILibrary
Resource          ../../Resource/Login/Login.resource
Resource          ../../Resource/Common/Commons.resource
Suite Setup         FSI Sys - Suite Setup
Suite Teardown      FSI Sys - Suite Teardown

*** Variables ***
${username_incorrect}    BHtest
${password_incorrect}   BHtest@1234
*** Test Cases ***
Check Login Successfully
    Login With Username And Password
Check Login With Username Incorrect And Password Correct
    Login With Username Incorrect    ${username_incorrect}
Check Login With Password Incorrect And Username Correct
    Login With Password Incorrect    ${password_incorrect}
Check Login With Password Is Empty
    Login With Password Is Empty    ${username_incorrect}
Check Login With Username Is Empty
    Login With Username Is Empty    ${password_incorrect}