*** Settings ***
Library    SeleniumLibrary
Library    DataDriver    file=jdd.csv    dialect=excel    encoding=UTF-8    
Library    ./fct.py

Test Template    Login To Saucedemo

*** Variables ***
${URL}        https://www.saucedemo.com/
${BROWSER}    firefox
${username}    username
${password}    password
${result}    result
*** Test Cases ***
Login Test With JDD    ${username}    ${password}    ${result}

*** Keywords ***
Login To Saucedemo
    [Arguments]    ${username}    ${password}    ${result}


    ${rows}=    Read Csv Skip Empty    jdd.csv
    FOR    ${row}    IN    @{rows}
        Log    Username=${row['username']} | Password=${row['password']} | Expected=${row['result']}
    END

    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=user-name    ${username}
    Input Password  id=password     ${password}
    Click Button    id=login-button

    # Vérifie le résultat attendu
    IF    '${result}' == 'ok'
        Wait Until Location Contains    inventory.html    5s
    ELSE
        Wait Until Page Contains        Epic sadface    5s
    END

    Close Browser
