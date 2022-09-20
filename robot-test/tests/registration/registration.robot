*** Settings ***
Documentation               Test suite for registration functionality
Resource                    ../../resources/common.resource
Resource                    ../../resources/pages/registration/registration.resource
Variables                    ../../resources/pages/login/login.yaml
Suite Setup                 Run Keyword
...                         Run Browser


*** Test Cases ***
Register User Using Valid Credentials
    [Documentation]         verfies user are able to register
    Go To Registration Page
    Set Username Text       ${USERNAME}
    Set Secret Password     ${PASSWORD}
    Set Firstname Text      ${FIRSTNAME}
    Set Lastname Text       ${LASTNAME}
    Set PhoneNumber Text    ${MOBILENUM}
    Submit Registration Information
    Assert Registraion Status        ${LOGIN_BUTTON}

Register User Using Already Used Username
    [Documentation]         verfies user are able to register
    Go To Registration Page
    Set Username Text       ${USERNAME}
    Set Secret Password     ${PASSWORD}
    Set Firstname Text      ${FIRSTNAME}
    Set Lastname Text       ${LASTNAME}
    Set PhoneNumber Text    ${MOBILENUM_2}
    Submit Registration Information
    Assert Registraion Status     ${ALREADY_REGISTERED}

Register User Using Already Used Phone Number
    [Documentation]         verfies user are able to register
    Go To Registration Page
    Set Username Text           ${USERNAME_2}
    Set Secret Password         ${PASSWORD}
    Set Firstname Text          ${FIRSTNAME}
    Set Lastname Text           ${LASTNAME}
    Set PhoneNumber Text        ${MOBILENUM}
    Submit Registration Information
    Assert Registraion Status     ${ALREADY_REGISTERED}

