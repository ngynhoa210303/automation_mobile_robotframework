*** Settings ***
Library     AppiumLibrary
Library     RPA.JSON
Library     ../../PyLibrary/custom_env.py
Library     ../../PyLibrary/custom_keywords.py
Library     DateTime
Library     OperatingSystem
Library     Process
Library     String


*** Variables ***
${ANDROID_AUTOMATION_NAME}      UIAutomator2
${ANDROID_PLATFORM_NAME}        Android
${ANDROID_PLATFORM_VERSION}     14
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
${results_save_dir}             ${EMPTY}
${file_name}                    ${EMPTY}
${noti_list}                    ['Email', 'SMS']
@{atribute}                     ID    Name_ID    Vietnamese    English    Type
${language}                     ${EMPTY}


*** Keywords ***
FSI Sys - Suite Setup
    Open Application    ${URL_APPLICATION}
    ...    automationName=${ANDROID_AUTOMATION_NAME}
    ...    platformName=${ANDROID_PLATFORM_NAME}
    ...    deviceName=RF8X407F2SN
    ...    platformVersion=${ANDROID_PLATFORM_VERSION}
    ...    appPackage=${ANDROID_APP_PACKAGE}
    ...    appActivity=${ANDROID_APP_ACTIVITY}
    ...    enforceXpath1=${ENFORCE_XPATH}
    ...    disableIdLocatorAutocompletion=${ID_ENABLE}
    ...    autoGrantPermissions=${PERMISSiON}
    ${project_path} =    Path To Project
    ${json_data} =    Load JSON from file    ${project_path}\\env_stag_testData.json
    Set Global Variable    ${test_json}    ${json_data}
    Get Username And Password From Json
    Get AccountNameCorrect And AccountNameCorrectIncorrect From Json
    Check Current Language

FSI Sys - Suite Teardown
    AppiumLibrary.Close Application

Get Username And Password From Json
    ${username_json} =    Get value from JSON    ${test_json}    $.login-test.user_name
    Set Global Variable    ${global_username}    ${username_json}
    ${password_json} =    Get value from JSON    ${test_json}    $.login-test.password
    Set Global Variable    ${global_password}    ${password_json}
    ${username_admin_json} =    Get value from JSON    ${test_json}    $.login-test.user_name_admin
    Set Global Variable    ${global_username_admin}    ${username_admin_json}
    ${password_admin_json} =    Get value from JSON    ${test_json}    $.login-test.password_admin
    Set Global Variable    ${global_password_admin}    ${password_admin_json}
    ${username_disable_json} =    Get value from JSON    ${test_json}    $.login-test.user_name_disble
    Set Global Variable    ${global_username_disable}    ${username_disable_json}
    ${password_disable_json} =    Get value from JSON    ${test_json}    $.login-test.password_disble
    Set Global Variable    ${global_password_disable}    ${password_disable_json}
    ${username_change_json} =    Get value from JSON    ${test_json}    $.login-test.user_name_change
    Set Global Variable    ${global_username_change}    ${username_change_json}
    ${password_change_json} =    Get value from JSON    ${test_json}    $.login-test.password_change
    Set Global Variable    ${global_password_change}    ${password_change_json}

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

Wait Element And Fail If Found
    [Arguments]    ${type}    ${identifier}    ${timeout}=10
    ${project_path} =    Path To Project
    ${location} =    Set Variable    ${type}=${identifier}
    ${status} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${location}
    ...    timeout=${timeout}
    IF    ${status} == ${True}
        Capture Page Screenshot    ${project_path}\\Screenshots\\ErrorReport_display_${TEST_NAME}.png
        Fail    ${identifier} working => fail
    END

Click On Element
    [Arguments]    ${type}    ${identifier}    ${timeout}=10
    Wait Element And Fail If Not Found    ${type}    ${identifier}
    ${location} =    Set Variable    ${type}=${identifier}
    Click Element    ${location}

Fill Input Text
    [Arguments]    ${type}    ${identifier}    ${text}
    Wait Element And Fail If Not Found    ${type}    ${identifier}
    ${location} =    Set Variable    ${type}=${identifier}
    ${attribute_id} =    Get Element Attribute    ${location}    resource-id
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
        Remove File    ${path}${results_save_dir}/${file_name}.mp4
    END

End Record
    ${path} =    PathToProject
    Stop Screen Recording    ${path}/${results_save_dir}/${file_name}
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

Setup Language
    [Arguments]    ${language}=//android.widget.TextView[@text="Tiếng Việt"]
    Click On Element    id    account_text_ChangeLanguage
    Click On Element    xpath    ${language}

Setup Language In Login Screen
    [Arguments]    ${language}
    Click On Element    id    auth_btn_ChangeLanguage
    IF    "${language}" == "VI"
        ${choose_language} =    Set Variable    auth_btn_Vietnamese
    ELSE
        ${choose_language} =    Set Variable    auth_btn_English
    END
    Click On Element    id    ${choose_language}
    Check Current Language

Get Value From Input Box
    [Arguments]    ${type}    ${identifier}    ${attribute}
    Wait Element And Fail If Not Found    ${type}    ${identifier}
    ${location} =    Set Variable    ${type}=${identifier}
    ${value} =    Get Element Attribute    ${location}    ${attribute}
    RETURN    ${value}

Capture Element Of Page
    [Arguments]    ${bounds_value}    ${FULL_SCREENSHOT}    ${x_path}
    Capture Page Screenshot    ${FULL_SCREENSHOT}
    ${startX} =    Get Element Coordinates    ${bounds_value}    startX
    ${startX_value} =    Evaluate    int('${startX}')
    ${endX} =    Get Element Coordinates    ${bounds_value}    endX
    ${endX_value} =    Evaluate    int('${endX}')
    ${startY} =    Get Element Coordinates    ${bounds_value}    startY
    ${startY_value} =    Evaluate    int('${startY}')
    ${endY} =    Get Element Coordinates    ${bounds_value}    endY
    ${endY_value} =    Evaluate    int('${endY}')
    Crop Image
    ...    ${FULL_SCREENSHOT}
    ...    ${startX_value}
    ...    ${startY_value}
    ...    ${endX_value}
    ...    ${endY_value}
    ...    ${x_path}

Random In Noti List
    [Arguments]    ${except_value}=${None}
    IF    ${{$except_value is not None}}
        ${chosen_noti} =    Evaluate
        ...    random.choice([item for item in ${noti_list} if item != '${except_value}'])
        ...    random
        RETURN    ${chosen_noti}
    ELSE
        ${chosen_noti} =    Evaluate    random.choice(${noti_list})    random
        RETURN    ${chosen_noti}
    END

Get Data From Json File
    [Arguments]    ${name_element}
    IF    "${name_element}" == "ID"
        ${id} =    Set Variable    ${atribute}[0]
    ELSE IF    "${name_element}" == "Name_ID"
        ${id} =    Set Variable    ${atribute}[1]
    ELSE IF    "${name_element}" == "Vietnamese"
        ${id} =    Set Variable    ${atribute}[2]
    ELSE IF    "${name_element}" == "English"
        ${id} =    Set Variable    ${atribute}[3]
    ELSE IF    "${name_element}" == "Type"
        ${id} =    Set Variable    ${atribute}[4]
    END
    RETURN    ${id}

Check Current Language
    Wait Element And Fail If Not Found    id    auth_btn_ChangeLanguage
    ${name} =    Get Value From Input Box    id    auth_btn_ChangeLanguage    content-desc
    IF    "${name}" == "Ngôn Ngữ"
        Set Global Variable    ${language}    VI
    ELSE
        Set Global Variable    ${language}    EN
    END

Get Label On Input Box
    [Arguments]    ${type}    ${locator}
    Fill Input Text    ${type}    ${locator}    bhtest

Compare Text
    [Arguments]    ${Screen}    ${type_of_locator}    ${xpath_in_json}    ${type_of_element}
    IF    "${type_of_locator}"=="id"
        IF    "${type_of_element}"=="button"
            ${value_compare} =    Get Value From Input Box    ${type_of_locator}    ${xpath_in_json}    content-desc
        ELSE
            ${value_compare} =    Get Value From Input Box    ${type_of_locator}    ${xpath_in_json}    text
        END
        ${element_text} =    Get Text From JSON    ${Screen}    ${xpath_in_json}
        Should Be Equal As Strings    ${value_compare}    ${element_text}
    ELSE
        ${element_in_json} =    Get Text From JSON    ${Screen}    ${xpath_in_json}
        ${locator_of_element_in_mobile} =    Set Variable    //android.widget.TextView[@text='${element_in_json}']
        IF    "${type_of_element}"=="button"
            ${value_element_in_mobile} =    Get Value From Input Box
            ...    ${type_of_locator}
            ...    ${locator_of_element_in_mobile}
            ...    content-desc
        ELSE
            ${value_element_in_mobile} =    Get Value From Input Box
            ...    ${type_of_locator}
            ...    ${locator_of_element_in_mobile}
            ...    text
        END
        Should Be Equal As Strings    ${element_in_json}    ${value_element_in_mobile}
    END

Check Blank Message Error
    [Arguments]    ${text}
    IF    "${language}" == "VI"
        Should Be Equal As Strings    ${text}    *Vui lòng nhập trường này!
    ELSE
        Should Be Equal As Strings    ${text}    *This field is required!
    END

Check Format Message Error
    [Arguments]    ${format}
    IF    "${language}" == "VI"
        Should Be Equal As Strings    ${format}    *Sai định dạng cho phép!
    ELSE
        Should Be Equal As Strings    ${format}    *Invalid format!
    END

Get Text From JSON
    [Arguments]    ${screen}    ${id_element}
    ${project_path} =    Path To Project
    ${multi_file} =    Set Variable    ${project_path}\\utils\\${language}.json
    ${file_exists} =    Run Keyword And Return Status    File Should Exist    ${multi_file}
    IF    ${file_exists} == False    Convert Excel To Custom Json    ${language}
    ${json_data} =    Load JSON from file    ${multi_file}
    Set Global Variable    ${language_json}    ${json_data}
    ${category_text} =    Get Value From JSON    ${language_json}    $.${language}.${screen}.${id_element}
    Log To Console    ${category_text}
    RETURN    ${category_text}
