*** Settings ***
Library           SeleniumLibrary



*** Variables ***
${url}            https://test.com/UserAccount/Login
${browser}        chrome
# Login
${username}               id=txtUsername
${password}               xpath=//input[@type='password' or @type='text']
${btn_login}              id=btnImageLogin
# MENU CHANGE PASS
${locator_setting}        xpath=//img[@title='ข้อมูลผู้ใช้งาน' and @alt='']
${locator_change_pass}    xpath=//a[@href='/UserAccount/AccountPassword']
${locator_CurrentPass}    id=txtCurrentPassword
${locator_NewPass}        id=txtNewPassword
${locator_verifyPass}     id=txtVerifyPassword
${locator_btnsave}        xpath=//*[@id="modalChangePassword"]/div/div/div[2]/div/div[2]/button[1]
# ALERT POPUP
${locator_Alert}          id=swal2-content
${locator_ok_alert}       xpath=/html/body/div[4]/div/div[3]/button[1]



*** Keywords ***
Open WMS
    [Documentation]    เปิดใช้งานหน้าเว็บไซต์ WMS
    # ตั้งค่าความเร็วของ Selenium อยู่ที่ 0.2s
    Set Selenium Speed    0.3s
    Open Browser          ${url}      ${browser}
    # เปิดหน้าต่าง Browser ให้เป็นจอใหญ่
    Maximize Browser Window
    Wait Until Element Contains       ${btn_login}    เข้าสู่ระบบ

Login WMS
    [Documentation]    ใช้สำหรับลงชื่อเข้าใช้ WMS
    Open WMS
    Wait Until Element Is Visible       ${username}
    Input Text       ${username}        test01
    Input Text       ${password}        P@ssw0rd
    Click Element    ${btn_login}
    Wait Until Page Contains Element    ${locator_setting}

Open Change Password
    [Documentation]    ใช้สำหรับคลิกเพื่อไปหน้าเปลี่ยนรหัสผ่าน
    Click Element    ${locator_setting}
    Wait Until Element Is Visible       ${locator_change_pass}
    Click Element    ${locator_change_pass}
    Wait Until Element Is Visible       ${locator_CurrentPass}

Input Login Again
    [Documentation]    ใช้สำหรับลงชื่อเข้าใช้ WMS กรณีเปลี่ยนรหัสผ่านสำเร็จอีกครั้ง
    [Arguments]    ${user}    ${pass}
    Open WMS
    Wait Until Element Is Visible       ${username}
    Input Text       ${username}        ${user}
    Input Text       ${password}        ${pass}
    Click Element    ${btn_login}
    Wait Until Page Contains Element    ${locator_setting}
    Open Change Password

Verify Change Password
    [Documentation]    ใช้สำหรับกรอกข้อมูลรหัสผ่าน และตรวจสอบการแจ้งเตือน
    [Arguments]    ${oldpass}    ${newpass}    ${confirmpass}
    Input Text     ${locator_CurrentPass}      ${oldpass}
    Input Text     ${locator_NewPass}          ${newpass}
    Input Text     ${locator_verifyPass}       ${confirmpass}
    click Element  ${locator_btnsave}

    IF    '${oldpass}' == '${EMPTY}' and '${newpass}' == '${EMPTY}' and '${confirmpass}' == '${EMPTY}'
        ${status} =    Run Keyword And Return Status    Check Text Alert    ระบุข้อมูลให้ถูกต้องและครบถ้วน!
        Check Alert Error Border    ${locator_CurrentPass}  
        Check Alert Error Border    ${locator_NewPass}
        Check Alert Error Border    ${locator_verifyPass}

    ELSE IF    '${newpass}' == '${oldpass}'
        ${status} =    Run Keyword And Return Status    Check Alert Ok    รหัสผ่านซ้ำกับปัจจุบัน กรุณาตรวจสอบ

    ELSE IF    '${newpass}' != '${confirmpass}'
        ${status} =    Run Keyword And Return Status    Check Text Alert    กรอกข้อมูลไม่ถูกต้อง กรุณาตรวจสอบ

    ELSE
        ${status} =    Run Keyword And Return Status    Check Alert Ok    เปลี่ยนรหัสผ่านสำเร็จ

        IF    '${status}' == 'False'  # ถ้าไม่มีข้อความ "เปลี่ยนรหัสผ่านสำเร็จ" แสดงว่ามีข้อผิดพลาด
            ${status} =    Run Keyword And Return Status    Check Alert Ok    รหัสผ่านไม่ถูกต้อง
        ELSE
            Wait Until Element Contains       ${btn_login}    เข้าสู่ระบบ
            Close Browser
        END

    END

Check Alert Error Border
    [Documentation]   ใช้สำหรับตรวจสอบกรอบแจ้งเตือนสีแดง
    [Arguments]    ${locator_error}
    # ดึงค่า style ของฟิลด์
    ${style}=    Get Element Attribute    ${locator_error}    style
    
Check Text Alert
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp
    [Arguments]    ${text}              
    ${swal2-title}=      Get Text    ${locator_Alert}
    Should Be Equal As Strings       ${swal2-title}        ${text} 

Check Alert Ok
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp คลิกตกลง
    [Arguments]    ${text}
    ${swal2-title}=    Get Text      ${locator_Alert}
    Should Be Equal As Strings       ${swal2-title}        ${text} 
    Wait Until Element Is Visible    ${locator_ok_alert}
    Click Element                    ${locator_ok_alert}
    


*** Test Cases ***
TC02-001 Verify Change Password Not Input - Fail
    [Documentation]   ตรวจสอบการเปลี่ยนรหัสผ่าน ไม่กรอกข้อมูล
    Login WMS
    Open Change Password
    Run Keyword    Verify Change Password    ${EMPTY}    ${EMPTY}    ${EMPTY}

TC02-002 Verify Change Currrent Password Input Invalid - Fail
    [Documentation]   ตรวจสอบการเปลี่ยนรหัสผ่านกรอกข้อมูล รหัสผ่านปัจจุบันไม่ถูกต้อง
    Run Keyword    Verify Change Password    P@ssw0rd2    P@ssw0rd1    P@ssw0rd1

TC02-003 Verify Change New Password Input Invalid - Fail
    [Documentation]   ตรวจสอบการเปลี่ยนรหัสผ่านกรอกข้อมูล รหัสผ่านใหม่ไม่ถูกต้อง
    Run Keyword    Verify Change Password    P@ssw0rd    P@ssw0rd12    P@ssw0rd1

TC02-004 Verify Change Confirm Password Input Invalid - Fail
    [Documentation]   ตรวจสอบการเปลี่ยนรหัสผ่านกรอกข้อมูล ยืนยันรหัสผ่านไม่ถูกต้อง
    Run Keyword    Verify Change Password    P@ssw0rd    P@ssw0rd1    P@ssw0rd12

TC02-005 Verify Change Duplicate Password Input - Fail
    [Documentation]   ตรวจสอบการเปลี่ยนรหัสผ่านกรอกข้อมูล รหัสผ่านใหม่และยืนยันรหัสผ่านซ้ำปัจจุบัน
    Run Keyword    Verify Change Password    P@ssw0rd    P@ssw0rd    P@ssw0rd

TC02-006 Verify Change Password Input Valid - Pass
    [Documentation]   ตรวจสอบการเปลี่ยนรหัสผ่านกรอกข้อมูล ถูกต้อง
    Run Keyword    Verify Change Password    P@ssw0rd    P@ssw0rd1    P@ssw0rd1

TC02-007 Change Password Input Valid - Pass
    [Documentation]   ตรวจสอบการเข้าสู่ระบบกรณีเปลี่ยนรหัสผ่านถูกต้อง และทำการเปลี่ยนรหัสผ่าเป็นรหัสเดิมเนื่องจากเมื่อเทสอีกรอบจะได้ไม่ต้องเปลี่ยนข้อมูล
    Run Keyword    Input Login Again         101670066    P@ssw0rd1
    Run Keyword    Verify Change Password    P@ssw0rd1    P@ssw0rd    P@ssw0rd