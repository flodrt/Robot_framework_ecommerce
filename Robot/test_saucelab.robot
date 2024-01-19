*** Settings ***
Library    SeleniumLibrary
#on factorise ici le debut (setup) et la fin (teardown de chaque test)
Test Setup    Open Browser    https://www.google.com/    chrome
Test Teardown    Close Browser

*** Variables ***
${BROWSER}    chrome
${BASE_URL}    https://www.google.com/
${LOGIN_URL}    https://www.saucedemo.com/
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

*** Test Cases ***
SauceLab Test
    # Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    30 seconds
    Login    ${USERNAME}    ${PASSWORD}
    Add Items To Cart
    Assert Cart
    Logout

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    Go To    ${LOGIN_URL}
    Input Text    id=user-name    ${username}
    Input Text    id=password    ${password}
    Click Button    id=login-button

Add Items To Cart
    Click Element    id=add-to-cart-sauce-labs-bike-light
    Click Element    id=add-to-cart-sauce-labs-fleece-jacket
    Click Element    id=add-to-cart-sauce-labs-bolt-t-shirt
    Click Element    xpath=//div[@id='shopping_cart_container']/a

Assert Cart
    ${cart_items} =    Get WebElements    xpath=//div[@id='cart_contents_container']/div/div/div[@class='cart_item']
    ${item_count} =    Get Length    ${cart_items}
    Should Be Equal As Numbers    ${item_count}    3    Le nombre d'éléments dans le panier n'est pas égal à 3

Logout
    Click Element    id=react-burger-menu-btn
    Click Element    id=logout_sidebar_link
    Sleep    10 seconds
    # [Teardown]    Close Browser
