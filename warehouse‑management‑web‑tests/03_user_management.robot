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
${locator_setting_user}    xpath=//a[@href='/Setting/UserAccount']
# User Account
${locator_btn_adduser}     id=btnCreateNew
# User Account / Add User
${locator_User}            id=txtUsername
${locator_Name}            id=txtFirstName
${locator_LastN}           id=txtLastName
${locator_Pass}            id=txtPassword
${locator_Status}          id=ddlIsActive
${locator_btn_Save}        id=btnSaveItemReceiveDetail
${locator_btn_Close}       id=btnCloseModal
# Search
${locator_search_id}       id=txtSearchUserName
${locator_Btn_search}      id=btnSearch
${locator_id_Table}        xpath=//*[@id="divSearch"]/div/div[2]/div/div[2]/div
${locator_clear_search}    xpath=//button[contains(., 'เคลียร์')]
# ALERT POPUP
${locator_Alert}           id=swal2-content
${locator_ok_alert}        xpath=/html/body/div[4]/div/div[3]/button[1]
${locator_Confirm}         xpath=/html/body/div[3]/div/div[3]/button[1]
${locator_Cancel}          xpath=/html/body/div[3]/div/div[3]/button[2]



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
    Input Text      ${username}      sysadmin
    Input Text      ${password}      P@ssw0rd
    Click Element   ${btn_login}
    Wait Until Page Contains Element    ${locator_setting}

Open Setting User Account
    [Documentation]    ใช้สำหรับเปิดหน้าตั้งค่าผู้ใช้งาน
    Login WMS
    Click Element    ${locator_setting}
    Wait Until Element Is Visible    ${locator_setting_user}
    Click Element    ${locator_setting_user}
    Wait Until Element Is Visible    ${locator_btn_adduser}

Add User Account
    [Documentation]    ใช้สำหรับเพิ่มผู้ใช้งาน
    [Arguments]    ${user}    ${name}    ${lastname}    ${password}    ${role}    ${status}
    Wait Until Element Is Visible    ${locator_btn_adduser}
    Click Element    ${locator_btn_adduser}
    Wait Until Element Is Visible    ${locator_user}
    Input Text    ${locator_User}    ${user}
    Input Text    ${locator_Name}    ${name}
    Input Text    ${locator_LastN}   ${lastname}
    Input Text    ${locator_Pass}    ${password}
    Click Element    xpath=//select[@id='ddlRole']//option[text()='${role}']
    Click Element    ${locator_Status}
    Select From List By Label        ${locator_Status}    ${status}
    Click Element    ${locator_btn_Save}

    # กำหนดค่าเริ่มต้น หากไม่มีเงื่อนไขไหนสำเร็จ ระบบจะส่งคืนค่าเป็น FALSE โดยอัตโนมัติ
    ${result}=    Set Variable    ${FALSE}

    # ตรวจสอบว่าช่อง user, name หรือ lastname ว่างหรือไม่ ถ้าว่าง ให้ทำงานดังนี้
    IF    '${user}' == '${EMPTY}' or '${name}' == '${EMPTY}' or '${lastname}' == '${EMPTY}' 
        Run Keyword    Check Text Alert    กรุณากรอกข้อมูลให้ครบถ้วน!
        Check Alert Error Border    ${locator_User}
        Check Alert Error Border    ${locator_Name} 
        Check Alert Error Border    ${locator_LastN}
        Check Alert Error Border    ${locator_Pass}
        Click Element    ${locator_btn_Close}
    ELSE
        # กรณีที่ข้อมูลไม่ว่าง ตรวจสอบว่าข้อมูลถูกต้องและเพิ่มผู้ใช้สำเร็จหรือไม่
        ${status} =    Run Keyword And Return Status    Check Text Alert    เพิ่มชื่อผู้ใช้ : ${user}

        # ถ้าไม่มีข้อความแจ้งเตือนการ "เพิ่มชื่อผู้ใช้" ให้ตรวจสอบเงื่อนไข IF
        IF    not ${status}
            Check Alert Ok    กรุณากรอกข้อมูลให้ถูกต้อง
            Wait Until Element Is Not Visible    ${locator_Alert}
            Click Element    ${locator_btn_Close}
        ELSE
            # ถ้าไม่เข้าเงื่อนไข IF ให้ตรวจสอบว่ามีข้อความแจ้งเตือน "มีชื่อผู้ใช้นี้อยู่แล้ว" หรือไม่
            ${status1} =    Run Keyword And Return Status    Check Alert Ok    มีชื่อผู้ใช้นี้อยู่แล้ว

            # ถ้าไม่เข้าเงื่อนไข "มีชื่อผู้ใช้นี้อยู่แล้ว" ให้ตั้งค่าตัวแปร ${result} เป็น ${TRUE}
            IF    not ${status1}
                ${result}=    Set Variable    ${TRUE}
            ELSE
                # หากถ้า "มีชื่อผู้ใช้อยู่แล้ว" → รอจนกว่า Alert จะหายไป
                Wait Until Element Is Not Visible    ${locator_Alert}
            END
        END
    END

    # ส่งค่าตัวแปร ${result} กลับไปยัง Test Case หรือ Keyword ค่า ${result} จะมีค่าเป็น ${TRUE} หากการเพิ่มผู้ใช้สำเร็จ ${FALSE} หากการเพิ่มผู้ใช้ล้มเหลว (เช่น กรอกข้อมูลไม่ครบ หรือมีชื่อซ้ำ)
    [Return]    ${result}

Search User Account
    [Documentation]    ใช้สำหรับตรวจสอบการ Search User Account
    [Arguments]    ${id}
    Input Text        ${locator_search_id}    ${id}
    Click Element     ${locator_Btn_search}
    Wait Until Element Contains        ${locator_id_Table}    ${id}

Clear Search User Account
    [Documentation]    ใช้สำหรับตรวจสอบการ Clear Search User Account
    Click Element     ${locator_clear_search}
    ${input_value}=    Get Value    ${locator_search_id}
    Should Be Equal    ${input_value}    ${EMPTY}
    

Edit User Account
    [Documentation]    ใช้สำหรับแก้ไขผู้ใช้งาน
    [Arguments]    ${id}    ${name}    ${lastname}    ${password}    ${role}    ${status}

    # ระบุ id ที่ต้องการแก้ไข คลิกปุ่ม Info โดยการระบุในการคลิกด้วย UserId
    Click Element    xpath=//tr[td[1][text()='${id}']]//button[contains(@onclick, 'UserDetail')]
    Wait Until Element Is Visible       ${locator_Name}
    Input Text       ${locator_Name}    ${name}
    Input Text       ${locator_LastN}   ${lastname}
    Input Text       ${locator_Pass}    ${password}
    Click Element    ${locator_btn_Save}

    IF    '${name}' == '${EMPTY}' or '${lastname}' == '${EMPTY}' or '${password}' == '${EMPTY}'
    ${status} =    Run Keyword And Return Status    Check Text Alert    กรุณากรอกข้อมูลให้ครบถ้วน!

        # ตรวจสอบ Error Border ตามข้อมูลที่ Empty
        IF    '${name}' == '${EMPTY}'
        Check Alert Error Border    ${locator_Name} 
        END
        IF    '${lastname}' == '${EMPTY}'
        Check Alert Error Border    ${locator_LastN} 
        END
        IF    '${password}' == '${EMPTY}'
        Check Alert Error Border    ${locator_Pass} 
        END

        Wait Until Element Is Not Visible    ${locator_Alert}
        Click Element    ${locator_btn_Close}

    ELSE 
        ${status} =    Run Keyword And Return Status    Check Text Alert    อัพเดตข้อมูลผู้ใช้ : ${id}
        Close Browser

        IF    '${status}' == 'False'  # ถ้าไม่มีข้อความ "อัพเดตข้อมูลผู้ใช้" แสดงว่ามีข้อผิดพลาด
        ${status} =    Run Keyword And Return Status    Check Text Alert    ข้อมูลผู้ใช้งานซ้ำ! กรุณาตรวจสอบ
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

Delete User Account
    [Documentation]    ใช้สำหรับลบ User Account
    [Arguments]    ${id}    ${confirm}
    
    # ระบุ id ที่ต้องการแก้ไข คลิกปุ่ม Info โดยการระบุในการคลิกด้วย UserId
    Click Element    xpath=//tr[td[1][text()='${id}']]//button[contains(@onclick, 'Delete')]
    Wait Until Element Is Visible         ${locator_Alert}
    ${swal2-title}=    Get Text           ${locator_Alert}
    Should Be Equal As Strings            ${swal2-title}      ยืนยันลบผู้ใช้งาน ?

    IF    '${confirm}' == 'Confirm'
        Click Element    ${locator_Confirm}
        Check Text Alert    ลบผู้ใช้งานสำเร็จ
    ELSE
        Click Element    ${locator_Cancel}
        Wait Until Element Is Not Visible    ${locator_Cancel} 
    END


*** Test Cases ***
TC03-001 Verify Add User Account - Fail
    [Documentation]   ตรวจสอบการแจ้งเตือนเพิ่ม User Account ไม่ถูกต้อง และตรวจสอบกรอบแจ้งเตือนสีแดง
    Open Setting User Account
    Add User Account    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    เทสสิทธ์1     - ระงับการใช้งาน -
    Add User Account    ${EMPTY}    Test        testadmin       P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -
    Add User Account    Tester      ${EMPTY}    testadmin       P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -
    Add User Account    Tester      Test        ${EMPTY}    P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -

TC03-002 Verify Add User Account - Pass
    [Documentation]   ตรวจสอบการแจ้งเตือนเพิ่ม User Account ถูกต้อง 
    Add User Account    Tester      Test        admin       P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -
    Close Browser

TC03-003 Verify Edit User Account - Fail
    [Documentation]   ตรวจสอบแจ้งเตือนการแก้ไข User Account ไม่ถูกต้อง และตรวจสอบกรอบแจ้งเตือนสีแดง
    Open Setting User Account
    Edit User Account    Tester    ${EMPTY}    testadmin    P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -
    Edit User Account    Tester    Test     ${EMPTY}    P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -
    

TC03-004 Verify Edit User Account - Pass
    [Documentation]   ตรวจสอบแจ้งเตือนการแก้ไข User Account ถูกต้อง
    Edit User Account    Tester    Test        testadmin    P@ssword    เทสสิทธ์1     - ระงับการใช้งาน -
    Close Browser

TC03-005 Verify Search User Account - Pass
    [Documentation]   ตรวจสอบการค้นหา User Account ถูกต้อง
    Open Setting User Account
    Search User Account    Tester

TC03-005 Verify Clear Search User Account - Pass
    [Documentation]   ตรวจสอบการล้างผลการค้นหา User Account ถูกต้อง
    Clear Search User Account

TC03-005 Verify Delete User Account - Fail
    [Documentation]   ตรวจสอบยกเลิกการลบ User Account 
    Delete User Account    Tester    Cancel

TC03-005 Verify Delete User Account - Pass
    [Documentation]   ตรวจสอบ Confirm การลบ User Account 
    Delete User Account    Tester    Confirm
    Close All Browsers

# เนื่องจาก Web ยังมี BUG อยู่การลบ User Account ต้องไปลบที่ SQL
