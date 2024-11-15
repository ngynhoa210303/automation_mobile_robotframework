*** Settings ***
Library             AppiumLibrary
Resource            ../../Resource/Account/Account.resource
Resource            ../../Resource/Common/Commons.resource
Suite Setup         FSI Sys - Suite Setup
Suite Teardown      FSI Sys - Suite Teardown

*** Test Cases ***
Upload image check
    [Tags]    medium    TC-11
    [Setup]   Update Information - Test Setup
    Upload Avatar
    [Teardown]    Remove Image - Test Teardown
View Infor
    [Tags]    medium    TC-12
    Login With Username And Password With User Account
    View Information Of User
