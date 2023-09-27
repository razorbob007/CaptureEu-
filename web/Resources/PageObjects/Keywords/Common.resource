*** Settings ***
Documentation  Common Steps BDD
Library  String
Library  SeleniumLibrary
Variables  ../TestData/TestData.py


*** Keywords ***
Input Field TXT
    [Documentation]  Selects the textbox and enters the value
    [Arguments]  ${Controll}    ${inputText}
    Input Text  ${Controll}  ${inputText}

Select A Country
    [Documentation]    Selects the country
    [Arguments]  ${Country_dd}    ${Country_Name}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Country_dd}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Country_Name}

Verify Price Without Vat
    [Documentation]  verifies the value of the label for the price without vat
    [Arguments]  ${VATpct2_lbl}  ${NetPrice}
    ${VATpct2_var}   Get Element Attribute    ${VATpct2_lbl}      value
    Textfield Value Should Be   ${VATpct2_lbl}   ${VATpct2_var}

    # verifies the value of the text box for the price without vat
    ${NetPrice_var}   Get Element Attribute     ${NetPrice_txt}      value
    Should Be Equal   ${NetPrice_var}    ${NetPrice}

Verify Value-Added Tax
    [Documentation]  verifies the value of the text box for the value-added tax
    [Arguments]  ${VATSum_txt}    ${VATsum}
    ${VATSum_var}   Get Element Attribute      ${VATSum_txt}      value
    Should Be Equal   ${VATSum_var}    ${VATsum}

Verify Price Inc Tax
    [Documentation]  Verifies the value of the text box for the price inc tax
    [Arguments]  ${Price_txt}    ${Price}
    ${Price_var}   Get Element Attribute      ${Price_txt}      value
    Should Be Equal   ${Price_var}    ${Price}

Sum Of Variables
    [Documentation]  Calculates the sum of the input variables
    [Arguments]   ${NetPrice_var}  ${VATSum_var}   ${Price_var}
    ${expectedResults}=  Evaluate  (${NetPrice_var} + ${VATSum_var})
    ${expectedResults}=  Convert To Number  ${expectedResults}    2
    ${expectedResults}=  Convert To String  ${expectedResults}
    ${expectedResults}=  Evaluate  "%.2f" % ${expectedResults}
    Should Be Equal   ${expectedResults}    ${Price_var}
