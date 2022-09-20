*** Settings ***
Documentation           keywords shared by all tests
Library                 Browser


*** Variables ***
${DEMO_APP_URL}         http://localhost:8080
${BROWSER}              chromium


*** Keywords ***
Run Browser
    [Documentation]     Opens browsers for running test cases
    Open Browser              ${DEMO_APP_URL}       ${BROWSER}

