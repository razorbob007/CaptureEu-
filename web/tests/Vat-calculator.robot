*** Settings ***
Documentation  Checkout Items E2E
Resource    ../Resources/PageObjects/Steps/Steps.robot


*** Test Cases ***
User Enters Price Without Vat
    [Documentation]    Check for Price Without Vat
    Given User Open Website
    When User Accepts All Cookies
    When User Selects A Country Austria
    When User Inputs Price Without Vat

User Enters Value-Added Tax
    [Documentation]    Check for Value-Added Tax
    Given User Open Website
    When User Accepts All Cookies
    When User Selects A Country Slovenia
    When User Inputs Value-Added Tax

User Enters Price Including Vat
    [Documentation]    Check for Price Including Vat
    Given User Open Website
    When User Accepts All Cookies
    When User Selects A Country Austria
    When User Inputs Price Incl VAT

User Enters Invalid Amount
    [Documentation]    Check for Invalid amount
    Given User Open Website
    When User Accepts All Cookies
    When User Selects A Country Austria
    When User Inputs Large Amount

User Enters Negative Amount
    [Documentation]     Check for Negative amounts in fields
    Given User Open Website
    When User Accepts All Cookies
    When User Selects A Country Austria
    When User Inputs Negative Values

User Enters Characters Into Amount
    [Documentation]     Check for Characters in amount fields
    Given User Open Website
    When User Accepts All Cookies
    When User Selects A Country Austria
    When User Inputs Characters Into Price Incl VAT
