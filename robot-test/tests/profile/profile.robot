*** Settings ***
Documentation           Test suite for reviewing user's profile
Resource                ../../resources/common.resource
Resource                ../../resources/pages/registration/registration.resource
Resource                ../../resources/pages/profile/profile.resource
Resource                ../../resources/pages/login/login.resource
Suite Setup                 Run Keyword
...                         Run Browser


*** Test Cases ***
Verify User's Credentials Saved After Registration
    [Documentation]       This test case verifies login and review user´s information
    [Tags]  Functional
    Go To Registration Page
    Set Username Text       ${user.username}
    Set Secret Password     ${user.password}
    Set Firstname Text      ${user.first_name}
    Set Lastname Text       ${user.last_name}
    Set PhoneNumber Text    ${user.phone_num}
    Submit Registration Information
    Log In User             ${user.username}       ${user.password}
    Verify Profile User's Information    ${user.username}   ${user.first_name}   ${user.last_name}   ${user.phone_num}
