*** Settings ***
Library    SeleniumLibrary
Resource    keywords.resource
Resource    variables.resource

*** Test Cases ***

Login
    [Tags]    valide
    Login valide
    login invalide

Produit
    ajout produit
    supprimer produit


