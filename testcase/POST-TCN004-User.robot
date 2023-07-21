*** Settings ***
Documentation    Negative Testcase - Create User with validate name >100 char
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      

*** Variables ***
${name_payload}    Jumlah kata adalah jumlah kata dalam suatu teks, sedangkan jumlah karakter adalah jumlah semua karakter123
${job_payload}     Testing

*** Test Cases ***
TCN-004 Create User with validate name >100 char
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     POST  
    Create Session     listuser           ${base_url}        verify=True
     ${header}=                           Create Dictionary
    ...                                   Content-Type=application/json
    ...                                   X-API-Auth=${EMPTY}
    ...                                   Cache-Control=no-cache 
    ...                                   Access-Control-Allow-Origin=*
    
    ${body}=                              Create Dictionary
    ...                                   name=${name_payload}
    ...                                   job=${job_payload}
    
    ${Response}=        POST On Session   listuser            /api/users       json=${body}    headers=${header}
    Should Be Equal As Strings    ${Response.status_code}    201

    #validation response body
    ${content}=    Convert To String    ${Response.content}
    Log    ${Response.content}

    ${jsondata}=        Convert String To Json    ${response.content}
    ${name}=            Set Variable        ${jsondata}[name]
    ${job}=             Set Variable        ${jsondata}[job]
    ${id}=              Set Variable        ${jsondata}[id]
    ${createdAt}=       Set Variable        ${jsondata}[createdAt]

    #verify data value name >100char
    ${length100char}=          Get Length            ${job}         #Here we get length of your input   
    Log     ${length100char}
    ${value}=    Convert To String    ${length100char}                                             #Here we can check what is the length (it is not necessary)
    ${check} =    Evaluate      ${value} > 100                 #Here we evaluate that input is more than 100  and get status (True or False)
    Should Be True    ${check}                                       #Here we validate that status should be true. If number is between >100 inclusive test will pass
   
    

    
