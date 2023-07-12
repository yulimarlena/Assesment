*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    Screenshot
Documentation
...    Technical Test to-do Item Bank Mas

*** Variables ***
${Host}                       https://todomvc.com/examples/knockoutjs/
${TitleKnokout.js}            Knockout.js • TodoMVC
${LocationFieldInputToDo}     xpath=//input[//header/input[1]]
@{ITEMS} =  Login  Register  Lupa Password  Verif KTP

*** Keywords ***
Navigate To Knockout.js • TodoMVC
    Open Browser    ${Host}    browser=chrome

Verify Page Title Contains Knockout.js • TodoMVC
    ${Get_title}=                 Get Title
    Should Be Equal As Strings    ${Get_title}    ${TitleKnokout.js}

Add to-do item list 
    Wait Until Element Is Visible    ${LocationFieldInputToDo}
    Input Text                       ${LocationFieldInputToDo}        Meeting With Project Manager
    Press Keys                       ${LocationFieldInputToDo}        Enter

For Looping add to-do item list
    FOR  ${MyItem}  IN  @{ITEMS}
       Log  ${MyItem}
        Input Text      ${LocationFieldInputToDo}        TestCases ${MyItem}
        Press Keys      ${LocationFieldInputToDo}        ENTER
       Run Keyword If   "${MyItem}" == "Verif KTP"  Exit For Loop
       Log  Didn't exit yet
    END

Done random click toggle task to-do item
    ${RandomGenerateToggle}    Generate Random String        1    12345
    ${ClikRandomToggle}       Catenate                ${RandomGenerateToggle}
    Click Element              xpath=//body/section[1]/section[1]/ul[1]/li[${ClikRandomToggle}]/div[1]/input[1] 

Filter to-do item All list
    Wait Until Element Is Visible    xpath=//a[contains(text(),'All')]
    Click Element      xpath=//a[contains(text(),'All')]
    Wait Until Page Contains    Meeting With Project Mananger
    FOR  ${MyItem}  IN  @{ITEMS}
       Log  ${MyItem}
       Wait Until Page Contains    ${MyItem}
    Run Keyword If   "${MyItem}" == "Verif KTP"  Exit For Loop
    END

Filter to-do item Active list
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Active')]
    Click Element                    xpath=//a[contains(text(),'Active')]
    Capture Page Screenshot
    FOR  ${MyItem}  IN  @{ITEMS}
        Log  ${MyItem}
        # Element Should Be Visible    //label[text()='${MyItem}']    error=False
        ${element_visible}=  Run Keyword And Return Status  
        ...  Element Should Be Visible     //label[text()='${MyItem}']    ${element_visible}
        Run Keyword If   "${MyItem}" == "Verif KTP"  Exit For Loop
    END

Filter to-do item Complete and Clear Complete list
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Completed')]
    Click Element    xpath=//a[contains(text(),'Completed')]
    Click Element    xpath=//a[contains(text(),'All')]
    ${RandomGenerateToggle}    Generate Random String        1    1234
    ${ClikaRandomToggle}       Catenate                ${RandomGenerateToggle}
    Click Element              xpath=//body/section[1]/section[1]/ul[1]/li[${ClikRandomToggle}]/div[1]/input[1]
    Click Element    xpath=//button[text()='Clear completed']

* Test Cases *
... Cases A) Menambahkan to-do item
    Navigate To Knockout.js • TodoMVC
    Verify Page Title Contains Knockout.js • TodoMVC
    Add to-do item list
    For Looping add to-do item list
... Cases B) Menyelesaikan to-do item
    Done random click toggle task to-do item
... Cases C) Filter to-do item
    Filter to-do item All list
    Filter to-do item Active list
... Cases D) Hapus to-do item
    Filter to-do item Complete and Clear Complete list
    Skip    Element Delete Not Clicking 'X'