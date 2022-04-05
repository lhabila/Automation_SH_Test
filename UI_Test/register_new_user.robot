*** Setting ***
Documentation          UI Automation for Registering New User and Reviewing User Details
Resource               ../Resources/resource_sh_demo_app.robot


*** Test Cases ***
Register through the web portal
        Launch_Browser_and_Open_Url
        Register_New_User_with_Personal_details
        Assert_that_new_registration_of_new_is_successful

Review user own information from the main view
        Launch_Browser_and_Open_Url
        Login_with_User_Details
        Assert_UserDetails_isDisplay_On_Main_View
