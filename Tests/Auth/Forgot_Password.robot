*** Settings ***
Library             AppiumLibrary
Resource            ../../Resource/Auth/Auth.resource
Resource            ../../Resource/Common/Commons.resource
Suite Setup         FSI Sys - Suite Setup
Test Setup          Create Test Record
Test Teardown       End Record
Suite Teardown      FSI Sys - Suite Teardown


*** Test Cases ***
Check Forgot Password Successfully
    [Tags]    medium    tc-9
    Forgot Password Successfully

Check Forgot Password With User Incorrect
    [Tags]    medium    tc-10
    Forgot Password With User Incorrect
