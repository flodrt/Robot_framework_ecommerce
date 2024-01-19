*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${BROWSER}   chrome
${SELSPEED}  0.4s
${nbteesh}        2

*** Test Cases *** 

robotframework-testing_selenium
    [Setup]  Run Keywords  Open Browser   https://magento.softwaretestingboard.com/?ref=hackernoon.com  ${BROWSER}
    ...              AND   Set Selenium Speed  ${SELSPEED}
    # open    https://codeshare.io/bv4ZWv
     
    # connection a son compte flo@hotmail.fr     mdp : floFLO06 
    click    xpath=//a[contains(text(),'Sign In')]
    open    https://magento.softwaretestingboard.com/customer/account/login/referer/aHR0cHM6Ly9tYWdlbnRvLnNvZnR3YXJldGVzdGluZ2JvYXJkLmNvbS8_cmVmPWhhY2tlcm5vb24uY29t/
    click    id=email
    type    id=email    flo@hotmail.fr
    click    id=pass
    type    id=pass    floFLO06
    click    xpath=//button[@id='send2']/span

    #page d'acceuil aprés connection + attendre 10 sec
    open    https://magento.softwaretestingboard.com/?ref=hackernoon.com
    Sleep    2    seconds
    # rentre dans le menu men
    click    xpath=//body[1]/div[2]/div[1]/div[1]/div[2]/nav[1]/ul[1]/li[3]/a[1]/span[2]
    open    https://magento.softwaretestingboard.com/men.html
    Sleep    2 seconds
    click    //body/div[2]/main[1]/div[4]/div[1]/div[2]/div[3]/div[1]/div[1]/ol[1]/li[1]/div[1]/a[1]/span[1]/span[1]/img[1]
                                #Ne trouve pas toujours l'image......
    
    
    #AJOUT AU PANIER : selection de le quantité, couleur et taille 
    open    https://magento.softwaretestingboard.com/argus-all-weather-tank.html
    Sleep    2 seconds
    click    id=qty  
    type     id=qty    ${nbteesh}                             # ecrit 2 dans la case des quantité     
    Sleep    2 seconds   
    click    id=option-label-size-143-item-166        #taille en XL
    click    id=option-label-color-93-item-52
    Capture Page Screenshot    choixdansladate.png
    click    xpath=//button[@id='product-addtocart-button']/span
    sleep     2seconds
    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='Toggle Nav'])[1]/following::a[2]
    Capture Page Screenshot    screenshot1.png
    click    xpath=//div[@id='minicart-content-wrapper']/div[2]/div[5]/div/a/span

   
    # retour au panier 
    open    https://magento.softwaretestingboard.com/checkout/cart/

    # # test pour voir si il y a effectivement 5 element dans le panier
    ${nb} =   Get Element Attribute        //main/div[3]/div/div[3]/form/div/table/tbody/tr/td/div/div/label/input     value
    ${tailleAvant} =     Get Text    //body[1]/div[2]/main[1]/div[3]/div[1]/div[3]/form[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]/div[1]/dl[1]/dd[1]
    # #${item_count} =    Get Length    ${cart_items}
         
    Log To Console       la taille avant est : ${tailleAvant}  
    Log To Console  Ma variable est :  =========>       ${nb}      ######################################################################################

    # test du nb d'element rajouté
    Should Be Equal    ${nb}      ${nbteesh}     Le nombre d'éléments dans le panier n'est pas égal au nombre d'element ajouté


     # clicker sur le petit crayon pour modifier > puis modifier la taille en M > update (reouvrir le panier) le panier et attendre 3sec
    click    xpath=//table[@id='shopping-cart-table']/tbody/tr[2]/td/div/a[2]
    Sleep    3    seconds
    click    id=option-label-size-143-item-168
    sleep     3 seconds
    click    xpath=//button[@id='product-updatecart-button']/span
    Capture Page Screenshot    screenshot.png
    ${tailleApres} =     Get Text    //body[1]/div[2]/main[1]/div[3]/div[1]/div[3]/form[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]/div[1]/dl[1]/dd[1]
    Log To Console       la taille apres est : ${tailleApres}

    #test du changement de taille
    Should Be Equal    ${tailleAvant}      XS
    Should Be Equal    ${tailleApres}      M
    Should Not Be Equal     ${tailleApres}     ${tailleAvant}

    # # # test pour voir si il y a effectivement 5 element dans le panier
    # # ${taille} =    Get Element Attribute        //dd[contains(text(),'XS')]     attribute=value
    # # #${item_count} =    Get Length    ${cart_items}
    # # Should Be Equal As Strings    ${taille}    XS   La taille n'est pas XS

    
    # une fois dans le panier , supprimer tous les articles 
    sleep     3 seconds
    click    xpath=//body[1]/div[2]/main[1]/div[3]/div[1]/div[3]/form[1]/div[1]/table[1]/tbody[1]/tr[2]/td[1]/div[1]/a[3]
    Sleep    5 seconds
    click    xpath=//img[contains(@src,'https://magento.softwaretestingboard.com/pub/static/version1695896754/frontend/Magento/luma/en_US/images/logo.svg')]
    open    https://magento.softwaretestingboard.com/
    click    xpath=//button[@type='button']
    #click    link=Sign Out


    [Teardown]  # Close Browser

*** Keywords ***
open
    [Arguments]    ${element}
    Go To          ${element}

clickAndWait
    [Arguments]    ${element}
    Click Element  ${element}

click
    [Arguments]    ${element}
    Click Element  ${element}

sendKeys
    [Arguments]    ${element}    ${value}
    Press Keys     ${element}    ${value}

submit
    [Arguments]    ${element}
    Submit Form    ${element}

type
    [Arguments]    ${element}    ${value}
    Input Text     ${element}    ${value}

selectAndWait
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

select
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

verifyValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

verifyTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertConfirmation
    [Arguments]                  ${value}
    Alert Should Be Present      ${value}

assertText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

assertTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

waitForTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

doubleClick
    [Arguments]           ${element}
    Double Click Element  ${element}

doubleClickAndWait
    [Arguments]           ${element}
    Double Click Element  ${element}

goBack
    Go Back

goBackAndWait
    Go Back

runScript
    [Arguments]         ${code}
    Execute Javascript  ${code}

runScriptAndWait
    [Arguments]         ${code}
    Execute Javascript  ${code}

setSpeed
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

setSpeedAndWait
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

verifyAlert
    [Arguments]              ${value}
    Alert Should Be Present  ${value}
