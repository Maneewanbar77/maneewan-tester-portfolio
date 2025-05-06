*** Settings ***
Library           SeleniumLibrary


*** Variables ***
${url}            https://test.com/UserAccount/Login
${browser}        chrome
# Login
${username}                id=txtUsername
${password}                xpath=//input[@type='password' or @type='text']
${btn_login}               id=btnImageLogin
${btn_eyepassword}         id=iEyeOfTiger
# main menu
${locator_setting}         xpath=//img[@title='ตั้งค่าข้อมูล' and @alt='']
${locator_setting_role}    xpath=//a[@href='/Setting/Role']
# Role
${locator_add_Role}    id=btnCreateNew

*** Keywords ***
Open WMS
    [Documentation]    เปิดใช้งานหน้าเว็บไซต์ WMS
    # ตั้งค่าความเร็วของ Selenium อยู่ที่ 0.2s
    Set Selenium Speed    0.3s
    Open Browser    ${url}           ${browser}
    # เปิดหน้าต่าง Browser ให้เป็นจอใหญ่
    Maximize Browser Window
    Wait Until Element contains      ${btn_login}    เข้าสู่ระบบ

Login WMS
    [Documentation]    ใช้สำหรับลงชื่อเข้าใช้ WMS
    Open WMS
    Wait Until Element Is Visible    ${username}
    Input Text      ${username}      testadmin
    Input Text      ${password}      P@ssw0rd
    Click Element   ${btn_login}
    Wait Until Page Contains Element    ${locator_setting}
 
Open Setting User Account
    [Documentation]    ใช้สำหรับเปิดหน้าตั้งค่าผู้ใช้งาน
    Login WMS
    Click Element    ${locator_setting}
    Wait Until Element Is Visible    ${locator_setting_role}
    Click Element    ${locator_setting_role}
    Wait Until Element Is Visible    ${locator_add_Role}