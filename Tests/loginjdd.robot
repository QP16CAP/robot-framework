*** Settings ***
Library    SeleniumLibrary
Library    ./fct.py

*** Variables ***
${URL}        https://www.saucedemo.com/
${BROWSER}    firefox
${CSV_FILE}   jdd.csv

*** Test Cases ***
Login Tests
    ${rows}=    Read Csv Skip Empty    ${CSV_FILE}
    FOR    ${row}    IN    @{rows}

        Log    Username=${row['username']} | Password=${row['password']} | Expected=${row['result']}
        Login To Saucedemo    ${row['username']}    ${row['password']}    ${row['result']}
    END

*** Keywords ***
Login To Saucedemo
    [Arguments]    ${username}    ${password}    ${result}
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button

    IF    '${result}' == 'ok'
        Wait Until Location Contains    inventory.html    5s
    ELSE
        Wait Until Page Contains        Epic sadface    5s
    END

    Close Browser
