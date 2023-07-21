*** Settings ***
Documentation    Negative Testcase - Get list user with Param ID Not Exist
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot  

*** Variables ***
${ID_param}    100

*** Test Cases ***
TCN-002 Get list user with Param ID Not Exist
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     GET       
    Create Session    listuser    ${base_url}    verify=True
    ${param}=       Create Dictionary    id=${ID_param}
    ${Response}=    GET On Session    listuser    /api/users       params=${param}    expected_status=ANY

    #check status code
    Should Be Equal As Strings    Not Found    ${Response.reason}