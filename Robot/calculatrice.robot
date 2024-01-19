*** Settings ***
Library  ../calculatrice.py



*** Test Cases ***
Test d'addition
    [Documentation]  test d'addition  # attention double espace

    ${result}    Addition    3    5  # recupere dans la variable result 
    Should Be Equal As Numbers    ${result}    8

Test de soustraction
    ${result}    Soustraction    5.0    2.0
    Should Be Equal As Numbers    ${result}    3.0

Test de multiplication
    ${result}    Multiplication    2.0    4.0
    Should Be Equal As Numbers    ${result}    8.0

Test de division
    ${result}    Division    8.0    2.0
    Should Be Equal As Numbers    ${result}    4.0

    ${error}    Division    5.0    0.0
    Should Be Equal    ${error}    Division par 0 impossible
