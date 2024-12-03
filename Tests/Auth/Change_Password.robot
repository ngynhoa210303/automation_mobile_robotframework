*** Settings ***
Library             AppiumLibrary
Resource            ../../Resource/Auth/Auth.resource
Resource            ../../Resource/Common/Commons.resource

Suite Setup         FSI Sys - Suite Setup
Test Setup          Create Test Record
Test Teardown       End Record
Suite Teardown      FSI Sys - Suite Teardown


*** Test Cases ***
Check Change Password With Text Field Empty
    [Tags]    medium    tc-12    tc-13    tc-14
    Change Password - SetUp
    Step To Change Password
    Change Password With Text Field Empty

Check Change Password With Current Password Wrong
    [Tags]    medium    tc-15
    Change Password With Current Password Wrong

Check Change Password With New Password Diffirent Confirm Password
    [Tags]    medium    tc-16
    Change Password With New Password Diffirent Confirm Password

Check Change Password With New Password Wrong Format
    [Tags]    medium    tc-17    tc-18    tc-19    tc-20    tc-21    tc-22    tc-23    tc-24
    Change Password With New Password Wrong Format

Check Change Password Successfully
    [Tags]    medium    tc-11
    Change Password Successfully
    [Teardown]    Change Password - Teardown
