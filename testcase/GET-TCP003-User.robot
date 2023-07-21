*** Settings ***
Documentation    Positive Testcase - Get List User with Param ID is match
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      


*** Variables ***
${ID_param}            9
${result_email}        tobias.funke@reqres.in
${result_fistname}     Tobias
${result_lastname}     Funke
${result_avatar}       https://reqres.in/img/faces/9-image.jpg


*** Test Cases ***
TCP-003 Get list user with Param ID and verify response body
    Verify Param Page is match

*** Keywords ***
Verify Param Page is match
    [Tags]     GET  
    Create Session    listuser    ${base_url}    verify=True
    ${param}=       Create Dictionary    id=${ID_param}
    ${Response}=    GET On Session    listuser    /api/users       params=${param}
    
    #check response body
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}

    #convert data to json 
    ${jsondata}=        Convert String To Json    ${response.content}
    ${data}=            Set Variable        ${jsondata}[data]
        ${data_id}=             Set Variable    ${jsondata}[data][id]
        ${data_email}=          Set Variable    ${jsondata}[data][email]
        ${data_first_name}=     Set Variable    ${jsondata}[data][first_name] 
        ${data_last_name}=      Set Variable    ${jsondata}[data][last_name]
        ${data_avatar}=         Set Variable    ${jsondata}[data][avatar] 
    
    #verify is match
    Should Be True    ${data_id}            ${ID_param}
    Should Be Equal    ${data_email}        ${result_email}
    Should Be Equal    ${data_first_name}   ${result_fistname}
    Should Be Equal    ${data_last_name}    ${result_last_name}
    Should Be Equal    ${data_avatar}       ${result_avatar}
    