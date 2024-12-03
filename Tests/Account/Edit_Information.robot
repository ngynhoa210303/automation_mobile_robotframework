*** Settings ***
Library             AppiumLibrary
Resource            ../../Resource/Account/Account.resource
Resource            ../../Resource/Common/Commons.resource

Suite Setup         FSI Sys - Suite Setup
Suite Teardown      FSI Sys - Suite Teardown
Test Setup          Create Test Record
Test Teardown       End Record

*** Test Cases ***
Check Upload Image
    [Tags]    medium    tc-25
    Upload Avatar
    [Teardown]    Remove Image If Test Passed

Check Update Infor Unsuccessfully With User Account
    [Tags]    medium    tc-26    tc-27    tc-28    tc-29    tc-30    tc-31  
    Update Information Unsuccessfully
    [Teardown]    Return Old Data Of Infor

Check Update Infor Successfully With User Account
    [Tags]    medium    tc-32    
    Update Information Successfully
    [Teardown]    Return Old Data Of Infor
Check LogTo
    [Tags]    medium    tc-32    
    Setup Language In Login Screen     auth_btn_English
    Fill Input Text    id    ${login_txt_username}    abc
    Fill Input Text    id    ${login_txt_password}    abc  
    Log To