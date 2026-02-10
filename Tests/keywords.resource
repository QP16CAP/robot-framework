*** Settings ***
Library    SeleniumLibrary
Resource    variables.resource

*** Keywords ***

Login valide
    Open Browser    ${site}     ${Browser}
    Input Text    ${usernamelocator}    standard_user
    Input Text    ${passwordlocator}    secret_sauce
    Click Element    ${loginbuttonlocator}
    ${text} =    Get Text    css=.title
    Should Contain    ${text}    Products
    Location Should Contain    inventory
    Close Browser

ajout produit
        Open Browser    ${site}     ${Browser}
    Input Text    ${usernamelocator}    standard_user
    Input Text    ${passwordlocator}    secret_sauce
    Click Element    ${loginbuttonlocator}
    Click Element    id=add-to-cart-sauce-labs-backpack
    ${text} =    Get Text    css=.shopping_cart_badge
    Should Contain    ${text}    1
    Close Browser

login invalide

    Open Browser    ${site}     ${Browser}
    Input Text    ${usernamelocator}    stand_user
    Input Text    ${passwordlocator}    secret_sauce
    Click Element    ${loginbuttonlocator}
    ${errormsg} =    Element Should Be Visible    css:[data-test="error"]
    ${errormsgtxt} =    Get Text    css:[data-test="error"]
    Should Contain    ${errormsgtxt}    Epic sadface
    Location Should Be    https://www.saucedemo.com/
    Close Browser


supprimer produit
        Open Browser    ${site}     ${Browser}
    Input Text    ${usernamelocator}    standard_user
    Input Text    ${passwordlocator}    secret_sauce
    Click Element    ${loginbuttonlocator}
    Click Element    id=add-to-cart-sauce-labs-backpack
    Click Element    css=.shopping_cart_link
    ${produitajoute} =    Get Text    css=.cart_list
    Should Contain    ${produitajoute}    Sauce Labs Backpack
    Click Element    id=remove-sauce-labs-backpack
    ${panier} =    Get Text    css=.cart_list
    Should Not Contain    ${panier}    Sauce Labs Backpack
    Close Browser