*** Settings ***
Documentation           keywords for log in page
Variables               login.yaml


*** Keywords ***
Log In User
    [Documentation]     Logs in user into account
    [Arguments]         ${u_name}               ${pwd}
    Fill Text           ${USERNAME_FIELD}       ${u_name}
    Fill Secret         ${PWD_FIELD}            $pwd
    Click               ${LOGIN_BUTTON}
