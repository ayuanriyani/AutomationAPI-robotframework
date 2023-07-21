*** Settings ***
Documentation    Negative Testcase - Delete User successfully
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot  

*** Variables ***
${Id_user}    5

*** Test Cases ***
TCP-001 Delete User successfully
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     DELETE  
    Create Session     listuser           ${base_url}        verify=True
   
    ${Response}=        DELETE On Session   listuser            /api/users/${Id_user}      
    Should Be Equal As Strings    ${Response.status_code}    204
    Should Be Equal As Strings    ${Response.reason}         No Content

    