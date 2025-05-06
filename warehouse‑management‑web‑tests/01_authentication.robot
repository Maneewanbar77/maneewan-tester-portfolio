*** Settings ***
Library           SeleniumLibrary


*** Variables ***
${url}            https://test.com/UserAccount/Login
${browser}        chrome
# Login
${username}            id=txtUsername
${password}            xpath=//input[@type='password' or @type='text']
${btn_login}           id=btnImageLogin
${btn_eyepassword}     id=iEyeOfTiger
# ALERT POPUP
${locator_Alert}       id=swal2-content
${locator_ok_alert}    xpath=/html/body/div[3]/div/div[3]
# main menu
${locator_setting}     xpath=//img[@title='ข้อมูลผู้ใช้งาน' and @alt='']
${locator_logout}      xpath=//a[@href='/UserAccount/LogOut']


*** Keywords ***
Open WMS
    [Documentation]    เปิดใช้งานหน้าเว็บไซต์ WMS
    # ตั้งค่าความเร็วของ Selenium อยู่ที่ 0.2s
    Set Selenium Speed    0.2s
    Open Browser          ${url}      ${browser}
    # เปิดหน้าต่าง Browser ให้เป็นจอใหญ่
    Maximize Browser Window
    Wait Until Element Contains    ${btn_login}    เข้าสู่ระบบ

Input Username Login - Fail
    [Documentation]    ใช้สำหรับตรวจสอบหน้า Login เคส Fail
    [Arguments]    ${user}    ${pass}
    Wait Until Element Is Visible    ${username}
    Input Text       ${username}    ${user}
    Input Text       ${password}    ${pass}
    Click Element    ${btn_login} 

    # ตรวจสอบกรณีทั้ง User และ Password ว่าง
    IF    '${user}' == '${EMPTY}' and '${pass}' == '${EMPTY}'
        ${status} =    Run Keyword And Return Status    Check Alert Ok    กรุณาระบุชื่อผู้ใช้. กรุณาระบุรหัสผ่าน.
    
    # ตรวจสอบกรณี Password ว่าง
    ELSE IF    '${pass}' == '${EMPTY}'
        ${status} =    Run Keyword And Return Status    Check Alert Ok    กรุณาระบุรหัสผ่าน.
    
    # ตรวจสอบกรณี User และ Password ไม่ว่าง
    ELSE
        ${status} =    Run Keyword And Return Status    Check Alert Ok    ไม่พบชื่อผู้ใช้
        Run Keyword If    '${status}' == 'False'        Check Alert Ok    ชื่อผู้ใช้ระงับการใช้งาน, โปรดติดต่อแอดมินของระบบ.
    END

Check Alert Ok
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp คลิกตกลง
    [Arguments]    ${text}
    ${swal2-title}=    Get Text      ${locator_Alert}
    # Wait Until Element Is Visible    ${swal2-title}
    Should Be Equal As Strings       ${swal2-title}      ${text} 
    Wait Until Element Is Visible    ${locator_ok_alert}
    Click Element                    ${locator_ok_alert}

Input Username Login - Pass
    [Documentation]    ใช้สำหรับตรวจสอบหน้า Login เคส Pass
    [Arguments]    ${user}    ${pass}
    Wait Until Element Is Visible    ${username}
    Input Text    ${username}        ${user}
    Input Text    ${password}        ${pass}
    Verify Password Visibility Toggle
    Click Element    ${btn_login}
    Wait Until Page Contains Element    ${locator_setting}

Verify Password Visibility Toggle
    [Documentation]    ใช้สำหรับตรวจสอบการเปิดปิดช่อง password
    # ตรวจสอบว่า type เป็น 'password' 
    ${type_before} =    Get Element Attribute    ${password}    type
    Log    "Type ก่อนคลิก: ${type_before}"
    Should Be Equal       ${type_before}    password

    # คลิกปุ่มเพื่อซ่อนรหัสผ่าน
    Click Element    ${btn_eyepassword}

    # ตรวจสอบว่า type เปลี่ยนเป็น 'text' หรือไม่
    ${type_after} =    Get Element Attribute    ${password}    type
    Log    "Type หลังคลิก: ${type_after}"
    Should Be Equal      ${type_after}    text

Verify User Log Out WMS
    [Documentation]    ใช้สำหรับตรวจสอบการ Log out
    Click Element    ${locator_setting}
    Wait Until Element Is Visible    ${locator_logout}
    Click Element    ${locator_logout}
    Wait Until Element Is Visible    ${username}
    Close All Browsers
    

*** Test Cases ***
TC01-001 User input data login - Fail
    [Documentation]    ตรวจสอบแจ้งเตือนไม่กรอกข้อมูลชื่อผู้ใช้งาน และรหัสผ่าน
    Run Keyword    Open WMS
    Run Keyword    Input Username Login - Fail    ${EMPTY}    ${EMPTY}
    Run Keyword    Input Username Login - Fail    xxxxxxxx    ${EMPTY}

TC01-002 User input data login - Fail
    [Documentation]    ตรวจสอบแจ้งเตือนชื่อผู้ใช้งาน และรหัสผ่าน ไม่ถูกต้อง
    Run Keyword    Input Username Login - Fail    000000000    xxx

TC01-003 User input data login - Fail
    [Documentation]    ตรวจสอบแจ้งเตือนชื่อผู้ใช้งานไม่ถูกต้อง และรหัสผ่านถูกต้อง
    Run Keyword    Input Username Login - Fail    000000000    P@ssw0rd

TC01-004 User input data login - Fail
    [Documentation]    ตรวจสอบแจ้งเตือนชื่อผู้ใช้งานถูกต้อง และรหัสผ่านไม่ถูกต้อง    
    Run Keyword    Input Username Login - Fail    testadmin    P@ss

TC01-005 User input data login - Fail
    [Documentation]    ตรวจสอบแจ้งเตือนชื่อผู้ใช้งาน สถานะระงับการใช้งาน 
    Run Keyword    Input Username Login - Fail    test01    P@ssw0rd
    Run Keyword    Close All Browsers

TC01-006 User input data login - Pass
    [Documentation]    ตรวจสอบการเปิด-ปิด รหัสผ่าน
    Run Keyword    Open WMS
    Run Keyword    Input Username Login - Pass    testadmin    P@ssw0rd

TC01-007 User Log Out WMS - Pass
    [Documentation]    ตรวจสอบกการกดออกจากระบบ
    Run Keyword    Verify User Log Out WMS
