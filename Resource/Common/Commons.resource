*** Settings ***
Library     AppiumLibrary
Library     RPA.JSON
Library     ../../PyLibrary/custom_env.py
Library     ../../PyLibrary/custom_keywords.py
Library     ../../.venv/lib/site-packages/FlaUILibrary/__init__.py


*** Variables ***
${ANDROID_AUTOMATION_NAME}      UIAutomator2
${ANDROID_PLATFORM_NAME}        Android
${ANDROID_PLATFORM_VERSION}     10.0
${ANDROID_APP_PACKAGE}          com.p0347_mobileapp
${ANDROID_APP_ACTIVITY}         com.p0347_mobileapp.MainActivity
${URL_APPLICATION}              http://127.0.0.1:4723
${ENFORCE_XPATH}                ${True}
${test_json}                    ${EMPTY}


*** Keywords ***
FSI Sys - Suite Setup
    Open Application    ${URL_APPLICATION}
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    appPackage=${ANDROID_APP_PACKAGE}
    ...    appActivity=${ANDROID_APP_ACTIVITY}
    ...    enforceXpath1=${ENFORCE_XPATH}

    ${project_path} =    Path To Project
    Take Screenshots On Failure    ${True}
    FlaUILibrary.Set Screenshot Directory    ${project_path}\\Screenshots
    ${json_data} =    Load JSON from file    ${project_path}\\env_testData.json
    Set Global Variable    ${test_json}    ${json_data}
    Get Username And Password From Json

FSI Sys - Suite Teardown
    AppiumLibrary.Close Application

Get Username And Password From Json
    ${username_json} =    Get value from JSON    ${test_json}    $.login-test.user_name
    Set Global Variable    ${global_username}    ${username_json}
    ${password_json} =    Get value from JSON    ${test_json}    $.login-test.password
    Set Global Variable    ${global_password}    ${password_json}

Wait Element And Fail If Not Found
    [Arguments]    ${identifier}    ${retry_time}=60
    ${status} =    Run Keyword And Return Status
    ...    Wait Until Element Exist
    ...    xpath=${identifier}
    ...    retries=${retry_time}
    IF    ${status} == ${False}
        Fail    ${identifier} not display or working
    ELSE
        Log To Console    ${identifier} displayed
    END
