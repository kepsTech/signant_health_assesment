*** Settings ***
Documentation           Keywords for profile page
Variables               profile.yaml
Variables               profile_data.yaml


*** Keywords ***
Verify Profile User's Information
    [Documentation]     verifies profile user data was saved correctly
    [Arguments]         ${username}     ${firstname}    ${lastname}     ${phone}
    Get Text            ${USERNAME_LOCATOR}  ==   ${username}
    Get Text            ${FIRSTNAME_LOCATOR}  ==   ${firstname}
    Get Text            ${lastname_locator}  ==   ${lastname}
    Get Text            ${phone_locator}  ==      ${phone}
