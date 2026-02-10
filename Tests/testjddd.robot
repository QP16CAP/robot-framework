*** Settings ***
Library    ./fct.py

*** Test Cases ***
Login Tests
    ${rows}=    Read Csv Skip Empty    jdd.csv
    FOR    ${row}    IN    @{rows}
        Log    Username=${row['username']} | Password=${row['password']} | Expected=${row['result']}
        # Ici tu mets ton code de login
    END
