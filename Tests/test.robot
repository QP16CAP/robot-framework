*** Settings ***
Library    SeleniumLibrary
Resource    keywords.resource
Resource    variables.resource


*** Test Cases ***

Login
    Login valide
    login invalide

Produit
    ajout produit
    supprimer produit


