*** Setting ***
Documentation           UI Automation for Registering New User and Reviewing User Details
Library                 SeleniumLibrary
Library                 FakerLibrary

*** Variables ***
${URL}                      http://192.168.1.205:8080/
${BROWSER}                  Headless Chrome
${REGISTRATION}             xpath:/html/body/nav/ul/li[1]/a
${LOGIN}                    xpath:/html/body/nav/ul/li[2]/a
${USERNAME}                 Sohvi
${PASSWORD}                 2020_2020
${USERNAME_FIELD}           id:username
${PASSWORD_FIELD}           id:password
${FIRSTNAME_FIELD}          name:firstname
${FAMILYNAME_FIELD}         id:lastname
${FIRSTNAME}                Sovhi
${FAMILYNAME}               Levi
${PHONE_FIELD}              id:phone
${PHONE_NUMBER}             +358404794805
${REGISTER}                 xpath:/html/body/section/form/input[6]
${SignIn}                   xpath:/html/body/section/form/input[3]


*** Keywords ***
Launch_Browser_and_Open_Url
        open browser                         ${URL}      ${BROWSER}
        maximize browser window
Register_New_User_with_Personal_details
        click element                       ${REGISTRATION}
        input text                          ${USERNAME_FIELD}       ${USERNAME}
        input text                          ${PASSWORD_FIELD}       ${PASSWORD}
        input text                          ${FIRSTNAME_FIELD}      ${FIRSTNAME}
        input text                          ${FAMILYNAME_FIELD}     ${FAMILYNAME}
        input text                          ${PHONE_FIELD}          ${PHONE_NUMBER}
        click element                       ${REGISTER}
Assert_that_new_registration_of_new_is_successful
        page should contain         Register
Login_with_User_Details
        Open Browser                        ${URL}                   ${BROWSER}
        click element                       ${LOGIN}
        input text                          ${USERNAME_FIELD}       ${USERNAME}
        input text                          ${PASSWORD_FIELD}       ${PASSWORD}
        click element                       ${SignIn}
Assert_UserDetails_isDisplay_On_Main_View
        page should contain                  ${USERNAME}
        page should contain                  ${FIRSTNAME}
        page should contain                  ${FAMILYNAME}
        page should contain                  ${PHONE_NUMBER}
