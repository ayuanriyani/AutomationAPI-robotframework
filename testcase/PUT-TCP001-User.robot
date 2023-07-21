*** Settings ***
Documentation    Positive Testcase - Update data User with check type data and response
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Library    DateTime
Resource            ../service/resource.robot      

*** Variables ***
${name_payload}    Employee-Success
${job_payload}     Testing
${Id_User}         4

*** Test Cases ***
TCP-001 Update data user successfully
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     PUT  
    Create Session     listuser         ${base_url}        verify=True
    ${body}=                              Create Dictionary
    ...                                   name=${name_payload}
    ...                                   job=${job_payload}
    
    ${Response}=        PUT On Session   listuser            /api/users/${Id_User}       json=${body}     expected_status=ANY
    Should Be Equal As Strings    ${Response.status_code}    200
    Should Be Equal As Strings    ${Response.reason}         OK

    #validation response body
    ${jsondata}=        Convert String To Json    ${response.content}
    ${name}=            Set Variable        ${jsondata}[name]
    ${job}=             Set Variable        ${jsondata}[job]
    ${updatedAt}=       Set Variable        ${jsondata}[updatedAt]

    ${CurrentDate}=    Get Current Date    result_format=%Y-%m-%d
    ${date}=            Convert Date    ${updatedAt}     result_format=%Y-%m-%d    exclude_millis=yes
    Should Be Equal    ${date}   ${CurrentDate}

    #verify data value match
    Log    ${name}
    Log    ${job}
    Should Be Equal As Strings    ${name}    ${name_payload}
    Should Be Equal As Strings    ${job}     ${job_payload}
    
    #check data type
    ${name}=             Evaluate          isinstance($name, str)
    Should be True       ${name}==True
    ${job}=              Evaluate          isinstance($job, str)
    Should be True       ${job}==True
    ${updatedAt}=        Evaluate          isinstance($updatedAt, str)
    Should be True       ${updatedAt}==True

  

   

    
