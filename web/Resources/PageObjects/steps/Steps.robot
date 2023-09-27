*** Settings ***
Documentation  Steps BDD
Library     SeleniumLibrary
Resource    ../Keywords/Common.resource
Variables  ../TestData/TestData.py


*** Variables ***
${SITE_URL}                    https://www.calkoo.com/en/vat-calculator
${BROWSER}                     Chrome
${CONSENT_BTN}                 xpath=//p[contains(text(),'Consent')]
${ACCEPT_BTN}                  xpath=//a[contains(text(),'I Accept!')]
${COUNTRY_DD}                  name=Country
${AUSTRIA_DD}                  xpath=//option[contains(text(),'Austria')]
${SLOVENIA_DD}                 xpath=//option[contains(text(),'Slovenia')]
${VAT_RATE_9.5_CHK}            xpath=//input[@id='VAT_9.5']
${VAT_RATE_10_CHK}             xpath=//input[@id='VAT_10']
${VAT_RATE_13_CHK}             xpath=//input[@id='VAT_13']
${VAT_RATE_20_CHK}             xpath=//input[@id='VAT_20']
${VAT_RATE_9.5_LBL}            xpath=//label[contains(text(),'9.5%')]
${VAT_RATE_10_LBL}             xpath=//label[contains(text(),'10%')]
${VAT_RATE_13_LBL}             xpath=//label[contains(text(),'13%')]
${VAT_RATE_20_LBL}             xpath=//label[contains(text(),'20%')]
${VALUE-ADDED TAX_CHK}         xpath=//label[contains(text(),'Value-Added Tax')]
${VATPCT2_LBL}                 xpath=//input[@id='VATpct2']
${NETPRICE_TXT}                xpath=//input[@id='NetPrice']
${VATSUM_TXT}                  xpath=//input[@id='VATsum']
${PRICE_TXT}                   xpath=//input[@id='Price']
${PRICE_INCL_VAT_CHK}          xpath=//label[contains(text(),'Price incl. VAT')]


*** Keywords ***
User Open Website
    [Documentation]    Opens the browser and navigates to the website
    Open Browser  ${site_url}  ${browser}
    Maximize Browser Window

User Accepts All Cookies
    [Documentation]    Accepts all cookies
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Consent_btn}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Accept_btn}

User Selects A Country Austria
    [Documentation]    Selects the country
    Select A Country    ${Country_dd}  ${Austria_dd}

User Inputs Price Without Vat
    [Documentation]     Inputs the Price Without Vat,
    ...     calculates the Value-Added Tax and the Price Incl VAT
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${VAT_Rate_13_lbl}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${NetPrice_txt}
    Input Field TXT      ${NetPrice_txt}    ${NetPrice}

    Verify Price Without Vat    ${VATpct2_lbl}  ${NetPrice}
    Verify Value-Added Tax   ${VATSum_txt}    ${VATsum}
    Verify Price Inc Tax    ${Price_txt}    ${Price}
    Sum Of Variables  ${NetPrice}  ${VATsum}  ${Price}

User Selects A Country Slovenia
    [Documentation]    Selects the country
    Select A Country    ${Country_dd}  ${Slovenia_dd}

User Inputs Value-Added Tax
    [Documentation]     Inputs the Value-Added Tax,
    ...     calculates the Price Without Vat and the Price Incl VAT
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${VAT_Rate_9.5_lbl}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${NetPrice_txt}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Value-Added Tax_chk}
    Input Field TXT      ${VATSum_txt}    ${VATsum2}

    Verify Price Without Vat    ${VATpct2_lbl}  ${NetPrice2}
    Verify Value-Added Tax   ${VATSum_txt}    ${VATsum2}
    Verify Price Inc Tax    ${Price_txt}    ${Price2}
    Sum Of Variables  ${NetPrice2}  ${VATsum2}  ${Price2}

User Inputs Price Incl VAT
    [Documentation]     Inputs the Price Incl Vat,
    ...     calculates the Value-Added Tax and the Price Without VAT
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Price_Incl_vat_chk}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${NetPrice_txt}
    Input Field TXT      ${Price_txt}    ${Price3}

    Verify Price Without Vat    ${VATpct2_lbl}  ${NetPrice3}
    Verify Value-Added Tax   ${VATSum_txt}    ${VATsum3}
    Verify Price Inc Tax    ${Price_txt}    ${Price3}
    Sum Of Variables  ${NetPrice3}  ${VATsum3}  ${Price3}

User Inputs Large Amount
    [Documentation]     Check For Large Amount
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Price_Incl_vat_chk}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${NetPrice_txt}
    Input Field TXT      ${Price_txt}    ${Amount}
    Verify Price Without Vat    ${VATpct2_lbl}  ${AmountErrorMsg}
    Input Field TXT      ${VATSum_txt}    ${Amount}
    Verify Value-Added Tax   ${VATSum_txt}    ${AmountErrorMsg}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Value-Added Tax_chk}
    Input Field TXT      ${VATSum_txt}    ${Amount}
    Verify Price Inc Tax    ${Price_txt}    ${AmountErrorMsg}

User Inputs Negative Values
    [Documentation]     Inputs the Price Incl Vat,
    ...     calculates the Value-Added Tax and the Price Without VAT
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Price_Incl_vat_chk}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${NetPrice_txt}
    Input Field TXT      ${Price_txt}    ${NetPrice5}
    Verify Price Without Vat    ${VATpct2_lbl}  ${ErrorMsg}
    Input Field TXT      ${VATSum_txt}    ${VATsum5}
    Verify Value-Added Tax   ${VATSum_txt}    ${ErrorMsg}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Value-Added Tax_chk}
    Input Field TXT      ${VATSum_txt}    ${Price5}
    Verify Price Inc Tax    ${Price_txt}    ${ErrorMsg}

User Inputs Characters Into Price Incl VAT
    [Documentation]     Check For Characters
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Price_Incl_vat_chk}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${NetPrice_txt}
    Input Field TXT      ${Price_txt}    ${Char}
    Verify Price Without Vat    ${VATpct2_lbl}  ${NetPrice4}
    Input Field TXT      ${VATSum_txt}    ${Char}
    Verify Value-Added Tax   ${VATSum_txt}    ${VATsum4}
    Wait Until Keyword Succeeds   10s    1s  Click Element   ${Value-Added Tax_chk}
    Input Field TXT      ${VATSum_txt}    ${VATsum4}
    Verify Price Inc Tax    ${Price_txt}    ${Price4}
