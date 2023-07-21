*** Settings ***
Documentation    Positive Testcase - Get List User all with check type data and response
Library            RequestsLibrary
Library            Collections
Library    JSONLibrary
Resource            ../service/resource.robot      


*** Test Cases ***
TCP-001 Get list user successfully
    Validate Status Code and Response Body 


*** Keywords ***
Validate Status Code and Response Body
    [Tags]     GET  
    Create Session    listuser    ${base_url}    verify=True
    ${Response}=    GET On Session    listuser    /api/users
    
    #validation status code
    ${status_code}=    Convert To String    ${Response.status_code}
    Should Be Equal    ${status_code}    200

    #validation response body
    ${content}=    Convert To String    ${Response.content}
    log    ${Response.content}
    ${jsondata}=        Convert String To Json    ${response.content}
    ${page}=            Set Variable        ${jsondata}[page]
    ${per_page}=        Set Variable        ${jsondata}[per_page]
    ${total}=           Set Variable        ${jsondata}[total]
    ${total_pages}=     Set Variable        ${jsondata}[total_pages]
    ${data}=            Set Variable        ${jsondata}[data]
        ${data_id}=             Set Variable    ${jsondata}[data][0][id]
        ${data_email}=          Set Variable    ${jsondata}[data][0][email]
        ${data_first_name}=     Set Variable    ${jsondata}[data][0][first_name] 
        ${data_last_name}=      Set Variable    ${jsondata}[data][0][last_name]
        ${data_avatar}=         Set Variable    ${jsondata}[data][0][avatar] 
    ${support}          Set Variable        ${jsondata}[support]
        ${support_url}          Set Variable        ${jsondata}[support][url]
        ${support_text}         Set Variable        ${jsondata}[support][text]

    #check data type
    ${page}=             Evaluate      isinstance($page, int)
    Should be True       ${page}==True
    ${per_page}=         Evaluate      isinstance($per_page, int)
    Should be True       ${per_page}==True
    ${total}=            Evaluate      isinstance($total, int)
    Should be True       ${total}==True
    ${total_pages}=      Evaluate      isinstance($total_pages, int)
    Should be True       ${total_pages}==True

    ${result}=         Evaluate        isinstance($data, list)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($data_id, int)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($data_email, str)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($data_first_name, str)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($data_last_name, str)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($data_avatar, str)
		Log     result = ${result}, expected str
		Should be True      ${result}==True

     ${result}=         Evaluate        isinstance($support, dict)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($support_url, str)
		Should be True      ${result}==True
		${result}=         Evaluate        isinstance($support_text, str)
		Should be True      ${result}==True
    


    
