*** Settings ***
Documentation    Negative Testcase - Create User with validate job <1 char
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      

*** Variables ***   
${job_payload}     Testing

*** Test Cases ***
TCN-005 Create User with validate job <1 char
    Validate Status Code and Response Body     #input job lebih dari 1 charcter


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     POST  
    Create Session     listuser           ${base_url}        verify=True
    ${body}=                              Create Dictionary
    ...                                   name=${EMPTY}
    ...                                   job=${job_payload}
    
   ${Response}=        POST On Session   listuser            /api/users       json=${body}    
    Should Be Equal As Strings    ${Response.status_code}    201

    #validation response body
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}

    ${jsondata}=        Convert String To Json    ${response.content}
    ${name}=            Set Variable        ${jsondata}[name]
    ${job}=             Set Variable        ${jsondata}[job]
    ${id}=              Set Variable        ${jsondata}[id]
    ${createdAt}=       Set Variable        ${jsondata}[createdAt]

    
    #verify data value job <1 char
    ${length<1char}=          Get Length         ${job}
    log    ${length<1char}
    ${value}=    Convert To String    ${length<1char} 
    ${check} =  Evaluate    ${value} <1 
    Should Be True    ${check}

    

    
