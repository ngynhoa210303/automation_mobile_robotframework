*** Settings ***
Library     AppiumLibrary
Library     RPA.JSON
Library     ../../PyLibrary/custom_env.py
Library     ../../PyLibrary/custom_keywords.py
Library     common_variable.py
Library     DateTime
Library     OperatingSystem
Library     Process
Library     String


*** Variables ***
${ANDROID_AUTOMATION_NAME}      UIAutomator2
${ANDROID_PLATFORM_NAME}        Android
${ANDROID_PLATFORM_VERSION}     10.0
${ANDROID_APP_PACKAGE}          com.p0347_mobileapp
${ANDROID_APP_ACTIVITY}         com.p0347_mobileapp.MainActivity
${URL_APPLICATION}              http://127.0.0.1:4723
${ENFORCE_XPATH}                ${True}
${test_json}                    ${EMPTY}
${FILE_MANAGER_PACKAGE}         com.android.documentsui
${FILE_MANAGER_ACTIVITY}        com.android.documentsui.files.FilesActivity
${FILE_MANAGER_ACTIVITY}        com.android.documentsui.files.FilesActivity
${ID_ENABLE}                    ${True}
${PERMISSiON}                   ${True}
${results_save_dir}            
${file_name} 

*** Keywords ***
FSI Sys - Suite Setup
    Open Application    ${URL_APPLICATION}
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    appPackage=${ANDROID_APP_PACKAGE}
    ...    appActivity=${ANDROID_APP_ACTIVITY}
    ...    enforceXpath1=${ENFORCE_XPATH}
    ...    disableIdLocatorAutocompletion=${ID_ENABLE}
    ...    autoGrantPermissions=${PERMISSiON}
    ${project_path} =    Path To Project
    ${json_data} =    Load JSON from file    ${project_path}\\env_testData.json
    Set Global Variable    ${test_json}    ${json_data}
    Get Username And Password From Json
    Get AccountNameCorrect And AccountNameCorrectIncorrect From Json

FSI Sys - Suite Teardown
    AppiumLibrary.Close Application

Get Username And Password From Json
    ${username_json} =    Get value from JSON    ${test_json}    $.login-test.user_name
    Set Global Variable    ${global_username}    ${username_json}
    ${password_json} =    Get value from JSON    ${test_json}    $.login-test.password
    Set Global Variable    ${global_password}    ${password_json}
    ${username_admin_json} =    Get value from JSON    ${test_json}    $.login-test.user_name
    Set Global Variable    ${global_username_admin}    ${username_admin_json}
    ${password_admin_json} =    Get value from JSON    ${test_json}    $.login-test.password
    Set Global Variable    ${global_password_admin}    ${password_admin_json}
    ${username_disable_json} =    Get value from JSON    ${test_json}    $.login-test.user_name_disble
    Set Global Variable    ${global_username_disable}    ${username_disable_json}
    ${password_disable_json} =    Get value from JSON    ${test_json}    $.login-test.password_disble
    Set Global Variable    ${global_password_disable}    ${password_disable_json}

Get AccountNameCorrect And AccountNameCorrectIncorrect From Json
    ${usercorrect_json} =    Get value from JSON    ${test_json}    $.forgot-password-test.user_account_correct
    Set Global Variable    ${global_usercorrect}    ${usercorrect_json}
    ${userincorrect_json} =    Get value from JSON    ${test_json}    $.forgot-password-test.user_account_incorrect
    Set Global Variable    ${global_userincorrect}    ${userincorrect_json}

Wait Element And Fail If Not Found
    [Arguments]    ${type}    ${identifier}    ${timeout}=60
    ${project_path} =    Path To Project
    ${location} =    Set Variable    ${type}=${identifier}
    ${status} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${location}
    ...    timeout=${timeout}
    IF    ${status} == ${False}
        Capture Page Screenshot    ${project_path}\\Screenshots\\ErrorReport_display_${TEST_NAME}.png
        Fail    ${identifier} not display or working
    END



Click On Element
    [Arguments]    ${type}    ${identifier}    ${timeout}=10
    Wait Element And Fail If Not Found    ${type}    ${identifier}    ${timeout}
    ${location} =    Set Variable    ${type}=${identifier}
    Click Element    ${location}

Fill Input Text
    [Arguments]    ${type}    ${identifier}    ${text}
    Wait Element And Fail If Not Found    ${type}    ${identifier}
    ${location} =    Set Variable    ${type}=${identifier}
    ${attribute_id} =    Get Element Attribute    ${location}    resource-id
    Log To Console    \nInput to ${attribute_id} now
    Input Text    ${location}    ${text}

Create Test Record
    ${path} =    PathToProject
    ${current_date_time} =    Get Current Date    result_format=%d-%m-%Y-%H-%M
    IF    "${results_save_dir}" == ""
        Set Global Variable    ${results_save_dir}    /Results/Results_${current_date_time}
        Set Global Variable    ${current_date_time_global}    ${current_date_time}
        Create New Folder    /Results
        Create New Folder    ${results_save_dir}
    END
    Set Global Variable    ${file_name}    ${TEST_NAME}-${current_date_time_global}
    Start Screen Recording  
Remove Record If Test Passed
    IF    "${TEST_STATUS}" == "PASS"
        ${path} =    PathToProject
        Log To Console    Sau Stop ${path}/${results_save_dir}/${file_name}
        Remove File   ${path}${results_save_dir}\\${file_name}
    END
End Record
    ${path} =    PathToProject
    Stop Screen Recording    ${path}/${results_save_dir}/${file_name}
    Log To Console    ${TEST_STATUS}
    Remove Record If Test Passed

Swipe Up
    [Arguments]    ${bounds_value_start}    ${bounds_value_end}
    ${startX} =    Get Element Coordinates    ${bounds_value_start}    startX
    ${endX} =    Get Element Coordinates    ${bounds_value_start}    endX
    ${startY} =    Get Element Coordinates    ${bounds_value_start}    startY
    ${endY} =    Get Element Coordinates    ${bounds_value_end}    endY
    ${XValue} =    Evaluate    random.randint(${startX}, ${endX})
    Swipe    ${XValue}    ${startY}    ${XValue}    ${endY}

Get Element Coordinates
    [Arguments]    ${bounds_value}    ${coordinate_name}
    ${getStartXY} =    Fetch From Left    ${bounds_value}    ]
    ${getStartXY} =    Fetch From Right    ${getStartXY}    [
    ${startX} =    Fetch From Left    ${getStartXY}    ,
    ${startY} =    Fetch From Right    ${getStartXY}    ,

    ${getEndXY_test} =    Fetch From Right    ${bounds_value}    [
    ${getEndXY_test} =    Fetch From Left    ${getEndXY_test}    ]
    ${endX} =    Fetch From Left    ${getEndXY_test}    ,
    ${endY} =    Fetch From Right    ${getEndXY_test}    ,
    IF    "${coordinate_name}" == "startX"    RETURN    ${startX}
    IF    "${coordinate_name}" == "startY"    RETURN    ${startY}
    IF    "${coordinate_name}" == "endX"    RETURN    ${endX}
    IF    "${coordinate_name}" == "endY"    RETURN    ${endY}

Swipe Down
    [Arguments]    ${bounds_value}    ${bounds_value_end}
    ${startX} =    Get Element Coordinates    ${bounds_value}    startX
    ${endX} =    Get Element Coordinates    ${bounds_value}    endX
    ${startY} =    Get Element Coordinates    ${bounds_value}    startY
    ${endY} =    Get Element Coordinates    ${bounds_value_end}    endY
    ${XValue} =    Evaluate    random.randint(${startX}, ${endX})
    Swipe    ${XValue}    ${endY}    ${XValue}    ${startY}