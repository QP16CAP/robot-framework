*** Settings ***
Library    SeleniumLibrary          # Importe la librairie Selenium pour piloter le navigateur
Suite Setup       Ouvrir le navigateur     # Hook exécuté avant toute la suite de tests
Suite Teardown    Fermer le navigateur     # Hook exécuté après toute la suite
Test Setup        Login valide             # Hook exécuté avant chaque test

*** Variables ***
${site} =  https://www.saucedemo.com/   # URL du site à tester
${Browser} =   firefox                    # Navigateur utilisé
${usernamelocator} =   id=user-name       # Locator du champ username
${passwordlocator} =   id=password        # Locator du champ password
${loginbuttonlocator} =   id=login-button     # Locator du bouton login

*** Test Cases ***
Ajouter produit et valider la commande            
    ajout produit                                 
    Aller au panier                       
    Vérifier produit dans panier          
    Checkout informations                 
    Valider la commande                  
    Vérifier confirmation commande        

*** Keywords ***

# HOOOOOOOOKKKKKSSSSSSS
# ---------- Gestion du navigateur ----------

Ouvrir le navigateur
    Open Browser    ${site}    ${Browser}     
    Maximize Browser Window                      

Fermer le navigateur
    Close Browser                            

# ---------- Login ----------

Login valide
    Input Text    ${usernamelocator}    standard_user   
    Input Text    ${passwordlocator}    secret_sauce    
    Click Element    ${loginbuttonlocator}              
    ${text}=    Get Text    css=.title                  
    Should Contain    ${text}    Products               
    Location Should Contain    inventory                

# ---------- Parcours commande ----------

ajout produit
    Click Element    id=add-to-cart-sauce-labs-backpack 
    ${text}=    Get Text    css=.shopping_cart_badge    
    Should Contain    ${text}    1                      
    Log    Produit ajouté au panier                    

Aller au panier
    Click Element    css=.shopping_cart_link            
    Location Should Contain    cart                     
    Log    Accès au panier                              

Vérifier produit dans panier
    ${produit}=    Get Text    css=.inventory_item_name 
    Should Contain    ${produit}    Sauce Labs Backpack 
    Log    Produit présent dans le panier               

Checkout informations
    Click Element    id=checkout        
    Input Text    id=first-name    Massinissa   
    Input Text    id=last-name     TAIBI        
    Input Text    id=postal-code   75000        
    Click Element    id=continue                
    Location Should Contain    checkout-step-two 
    Log    Informations de livraison saisies    

Valider la commande
    Click Element    id=finish    
    Log    Commande validée      

Vérifier confirmation commande
    ${msg}=    Get Text    css=.complete-header   
    Should Contain    ${msg}    Thank you for your order 
    Log    Confirmation de commande affichée      
