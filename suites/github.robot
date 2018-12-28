*** Settings ***
Library     HttpLibrary.HTTP
ForceTags   MediumStoryREST

*** Variables ***
${token}           ?
${requestUri}      /user
${ACCESS_TOKEN}    %{ACCESS_TOKEN}


*** Keywords ***
users fullname "${fullname}"
    Set Suite Variable      ${fullname}     ${fullname} 

is fetching his profile from api
    Create Http Context     api.github.com      scheme=https
    Set Request Header      User-Agent          Robot-Testing
    Next Request May Not Succeed
    GET                     ${requestUri}${token}

request is forbidden
    Response Status Code Should Equal          401
    Response Body Should Contain        Requires authentication
    
user is authorized
    Set Suite Variable      ${token}      ?access_token=${API_TOKEN}
    
users profile is retrieved
    Response Status Code Should Equal          200
    Response Body Should Contain        ${fullname}