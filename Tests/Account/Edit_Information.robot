*** Settings ***
Library             AppiumLibrary
Resource            ../../Resource/Account/Account.resource
Resource            ../../Resource/Common/Commons.resource
Suite Setup         FSI Sys - Suite Setup
Suite Teardown      FSI Sys - Suite Teardown

*** Test Cases ***
Upload image check
    [Tags]    medium    TC-11
    Upload Avatar
    [Teardown]     Remove Avatar - Test Teardown
Update Infor With User Account
    [Tags]    medium    TC-12
    Login With Username And Password With User Account
    Click On Element    id    ${bottom_menubar_account}
    Click On Element    id    ${account_btn_acc_information}
   
Update Infor With Admin Account
    [Tags]    medium    TC-13
    Update Information With Admin Role - Test Setup