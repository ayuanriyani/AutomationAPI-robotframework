*** Settings ***
Documentation    Negative Testcase - Get List User with Wrong Endpoint
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot  


*** Test Cases ***
TCN-001 Get list user successfully
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     GET  
    Create Session    listuser    ${base_url}    verify=True
    ${Response}=    GET On Session    listuser    /api/use
    
    #validation status code
    ${status_code}=    Convert To String    ${Response.status_code}
    Should Be Equal    ${status_code}    500
    
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}
    Should Contain Match     ${Response.content}    bad request
