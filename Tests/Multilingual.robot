*** Settings ***
Library             AppiumLibrary
Resource            ../Resource/Login/Login_Logout.resource
Resource            ../Resource/Common/Commons.resource
Resource            ../Resource/Multilingual/Multilingual.resource

Suite Setup         FSI Sys - Suite Setup
Suite Teardown      FSI Sys - Suite Teardown
Test Setup          Create Test Record
Test Teardown       End Record


*** Variables ***
${VIETNAMESE}       VI
${ENGLISH}          EN


*** Test Cases ***
Check Multilingual - Vietnamese Language
    [Tags]    medium    lg-1
    Multilingual Check    ${VIETNAMESE}
    Sleep    2
    Multilingual Check    ${ENGLISH}

