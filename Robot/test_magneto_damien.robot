*** Settings ***
Library           SeleniumLibrary
Test Setup    Open Browser    https://www.google.com/    chrome
Test Teardown    Close Browser

*** Variables ***
${BASE_URL}       https://www.google.com/
${URL}    https://magento.softwaretestingboard.com/
${EMAIL}    d@d.fr
${PASSWORD}    Da12345678

*** Test Cases ***
Luma Test
    Maximize Browser Window
    Login    ${EMAIL}    ${PASSWORD}
    Navigate to Subsubmenu
    Add Items To Cart
    # Count Articles With Quantity in Cart
    Logout
   
*** Keywords ***
Login
    [Documentation]    Test du formule de connexion
    [Arguments]    ${EMAIL}    ${PASSWORD}
    Go To    ${URL}
    Click Element    link=Sign In
    Input Text    id=email    ${EMAIL}
    Input Text    id=pass    ${PASSWORD}
    Click Element    xpath=//form[@id='login-form'][1]/fieldset/div[4]/div[1]/button/span

Navigate to Subsubmenu
    [Documentation]    Test de redirection à partir d'un dropdown
    Mouse Over   xpath=//nav[@class='navigation'][1]/ul/li[3]/a/span
    Mouse Over    xpath=//ul[@class='level0 submenu ui-menu ui-widget ui-widget-content ui-corner-all']/li[@class='level1 nav-3-1 category-item first parent ui-menu-item'][1]/a/span[2]
    Click Element    xpath=//ul[@class='level1 submenu ui-menu ui-widget ui-widget-content ui-corner-all expanded']/li[@class='level2 nav-3-1-1 category-item first ui-menu-item']/a/span[1]

Add Items To Cart
    [Documentation]    Test d'ajout d'articles au panier
    Click Element    id=option-label-size-143-item-169
    Click Element    id=option-label-color-93-item-50
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li/div/div/div[3]/div/div/form/button/span
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[4]/div/div/div[2]/div/div/div[4]
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[4]/div/div/div[2]/div[2]/div/div
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[4]/div/div/div[3]/div/div/form/button/span
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[6]/div/div/div[3]/div/div/div[5]
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[6]/div/div/div[3]/div[2]/div/div
    Click Element    xpath=//main[@id='maincontent']/div[3]/div/div[4]/ol/li[6]/div/div/div[4]/div/div/form/button/span  
    Click Element    xpath=(.//*[normalize-space(text()) and normalize-space(.)='Toggle Nav'])[1]/following::a[2]

Count Articles With Quantity in Cart
    ${total_quantity}    Set Variable    0
    ${article_elements}    Get WebElements    xpath=//header[@class='page-header']/div[@class='header content']/div/div/div/div/div/div[4]/ol/li

    FOR    ${element}    IN    @{article_elements}
        ${quantity}    Get Element Attribute    //header[@class='page-header']/div[@class='header content']/div/div/div/div/div/div[4]/ol/li/div/div/div[@class='product-item-pricing']/div[2]/input    data-item-qty
        Log    Quantité: ${quantity}
        ${total_quantity}    Evaluate    ${total_quantity} + int(${quantity})
    END

    Log    Nombre total d'elements dans le panier: ${total_quantity}
    Should Be Equal As Numbers    ${total_quantity}    15

Logout
    [Documentation]    Test du deconnexion
    Wait Until Page Contains Element    xpath=//div[@class='panel header'][1]/ul[@class='header links']    timeout=10s 
    Click Button   xpath=//div[@class='panel header'][1]/ul[@class='header links'][1]/li[@class='customer-welcome']/span/button
    Click Element    xpath=//div[@class='customer-menu']/ul/li[@class='authorization-link']/a