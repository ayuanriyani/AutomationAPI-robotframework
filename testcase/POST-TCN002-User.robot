*** Settings ***
Documentation    Negative Testcase - Create User Empty Job
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      

*** Variables ***
${name_payload}     nama testing

*** Test Cases ***
TCN-002 Create data user Empty Job
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     POST  
    Create Session     listuser           ${base_url}        verify=True
    ${body}=                              Create Dictionary
    ...                                   name=${name_payload}
    ...                                   job=${EMPTY}
    
    ${Response}=        POST On Session   listuser            /api/users       json=${body}    
    Should Be Equal As Strings    ${Response.status_code}    201
    Should Be Equal As Strings    ${Response.reason}         Created

    #validation response body
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}

    ${jsondata}=        Convert String To Json    ${response.content}
    ${name}=            Set Variable        ${jsondata}[name]
    ${job}=             Set Variable        ${jsondata}[job]
    ${id}=              Set Variable        ${jsondata}[id]
    ${createdAt}=       Set Variable        ${jsondata}[createdAt]
    
    #verify data value
    Log    ${name}
    Log    ${job}
    Should Be Equal As Strings    ${name}    ${name_payload}
    Should Be Equal As Strings    ${job}     ${EMPTY}

    #check data type
    ${name}=             Evaluate          isinstance($name, str)
    Should be True       ${name}==True
    ${job}=              Evaluate          isinstance($job, str)
    Should be True       ${job}==True
    ${id}=               Evaluate          isinstance($id, str)
    Should be True       ${id}==True
    ${createdAt}=        Evaluate          isinstance($createdAt, str)
    Should be True       ${createdAt}==True

 
          
   
   

    
