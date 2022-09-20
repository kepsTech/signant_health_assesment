*** Settings ***
Documentation         Registration page kewords
Variables             registration.yaml


*** Keywords ***
Go To Registration Page
    [Documentation]       opens registration page
    Go To                 ${DEMO_APP_URL}/register

Set Username Text
    [Documentation]        provides date for username
    [Arguments]            ${u_name}
    Fill Text              ${USERNAME_FIELD}        ${u_name}

Set Secret Password
    [Documentation]        provides date for username
    [Arguments]            ${pwd}
    Fill Secret            ${PASSWORD_FIELD}        $pwd

Set Firstname Text
    [Documentation]        provides date for username
    [Arguments]            ${f_name}
    Fill Text             ${FIRSTNAME_FIELD}         ${f_name}

Set Lastname Text
    [Documentation]        provides date for username
    [Arguments]            ${l_name}
    Fill Text             ${LASTNAME_FIELD}         ${l_name}

Set PhoneNumber Text
    [Documentation]        provides date for username
    [Arguments]            ${phone_num}
    Fill Text             ${MOBILENUM_FIELD}        ${phone_num}

Submit Registration Information
    [Documentation]        clicks submit button
    Click                  ${REGISTRATION_BUTTON}

Assert Registraion Status
    [Documentation]        verifies the status of user's registration
    [Arguments]            ${locator_field}
    Wait For Elements State        ${locator_field}        state=visible
