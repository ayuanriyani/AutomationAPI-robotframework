*** Settings ***
Documentation    Positive Testcase - Get List User with Param Page is match
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      


*** Variables ***
${page_param}        2

*** Test Cases ***
TCP-002 Get list user with Param Page
    Verify Param Page is match

*** Keywords ***
Verify Param Page is match
    [Tags]     GET  
    Create Session    listuser    ${base_url}    verify=True
    ${param}=       Create Dictionary    page=${page_param}
    ${Response}=    GET On Session    listuser    /api/users       params=${param}
    
    #check response body
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}

    #convert data to json 
    ${jsondata}=        Convert String To Json    ${response.content}
    ${page}=            Set Variable        ${jsondata}[page]
    
    #verify is match
    Should Be True    ${page}    ${page_param}
    