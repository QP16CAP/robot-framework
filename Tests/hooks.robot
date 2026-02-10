*** Settings ***
Library    SeleniumLibrary
Suite Setup       Ouvrir le navigateur
Suite Teardown    Fermer le navigateur
Test Setup        Login valide

*** Variables ***
${site} =  https://www.saucedemo.com/ 
${Browser} =   firefox 
${usernamelocator} =   id=user-name
${passwordlocator} =   id=password
${loginbuttonlocator} =   id=login-button

*** Test Cases ***
Ajouter un produit au panier
    ajout produit

*** Keywords ***
# ---------- Gestion du navigateur ----------
Ouvrir le navigateur
    Open Browser    ${site}    ${Browser}
    Maximize Browser Window
    Log    Navigateur ouvert

Fermer le navigateur
    Close Browser
    Log    Navigateur fermé

# ---------- Login  ----------
Login valide
    Input Text    ${usernamelocator}    standard_user
    Input Text    ${passwordlocator}    secret_sauce
    Click Element    ${loginbuttonlocator}
    ${text}=    Get Text    css=.title
    Should Contain    ${text}    Products
    Location Should Contain    inventory
    Log    Utilisateur connecté


# ---------- Keywords métiers ----------
ajout produit
    Click Element    id=add-to-cart-sauce-labs-backpack
    ${text}=    Get Text    css=.shopping_cart_badge
    Should Contain    ${text}    1
    Log    Produit ajouté au panier


