*** Settings ***
Documentation    Negative Testcase - Create User Without Token
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      

*** Variables ***
${name_payload}     coba satu
${job_payload}        coba job
${token}        gubu8746387dggdwgewucs8ayef887b6x3276276x

*** Test Cases ***
TCN-003 Create data user Without Token
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     POST  
    Create Session     listuser           ${base_url}        verify=True
    ${header}=                            Create Dictionary
    ...                                   Content-Type=application/json
    ...                                   X-API-Auth=${EMPTY}
    ...                                   Authorization=${token}  
    
    ${Bearer}=    Set Variable  Bearer
    ${token}=     Catenate      Bearer${SPACE}${token}
    Set Global Variable         ${token}
    
    ${body}=                              Create Dictionary
    ...                                   name=${name_payload}
    ...                                   job=${job_payload}
    
    ${Response}=        POST On Session   listuser            /api/users       json=${body}    headers=${header}
    Should Be Equal As Strings    ${Response.status_code}    401
    Should Be Equal As Strings    ${Response.reason}         UNAUTHORIZED

    #validation response body
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}

    
   
   

    
