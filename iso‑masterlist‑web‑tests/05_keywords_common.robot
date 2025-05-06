***Settings***
Library    SeleniumLibrary
Library    OperatingSystem
Resource    ${CURDIR}/00_variables.robot
# Resource    ${CURDIR}/CSP_Masterlis_Detail1.robot



***Keywords***
Open Test Master
    [Documentation]    เปิดโปรแกรม
    Set Selenium Speed    0.1s
    Open Browser    ${url}      ${browser}
    Maximize Browser Window


Verify Input User And Password Login - Fail
    [Documentation]    ตรวจสอบกรณี กรอกชื่อผู้ใช้ หรือรหัสผ่านผิด
    #สร้างตัวแปรเพื่อแทนค่า
    [Arguments]     ${User}    ${Pass}   
    Open Test Master
    Input Text      ${locator_inputUser}    ${User}
    Input Text      ${locator_inputPass}    ${Pass}
    Click Element    //button[@type="submit"]


    #เงื่อนไข เมื่อช่อง ${User} = ${EMPTY} ให้ตรวจสอบว่า msg ขึ้นหรือไม่
    IF        "${User}" == "${EMPTY}"
               Verify Error Message Login - Fail    ${locator_msg_User}         ระบุชื่อผู้ใช้ 
    END

    #เงื่อนไข เมื่อช่อง ${Pass} = ${EMPTY} ให้ตรวจสอบว่า msg ขึ้นหรือไม่
    IF         "${Pass}" == "${EMPTY}"
                Verify Error Message Login - Fail   ${locator_msg_Pass}         ระบุรหัสผ่าน    
    END

    #เงื่อนไข เมื่อช่อง ${User} = 000000000 หรือ เมื่อช่อง ${Pass} = P@ss ให้ตรวจสอบว่า ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง 
    IF         "${User}" == "000000000"
                Verify Error Message Login - Fail    ${locator_msg_UserPass}    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
    ELSE IF    "${Pass}" == "P@ss"
                Verify Error Message Login - Fail    ${locator_msg_UserPass}    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
    END

    #เงื่อนไข เมื่อ ${User} = 101580147 ให้ทำ ${Pass} = Noon@nisa061 แล้วตรวจสอบว่ามีการแจ้งเตือน
    IF         "${User}" == "101580147"
        IF     "${Pass}" == "Noon@nisa061"  
                ${modal}=    Get WebElement          ${locator_alert_Popup}
                Wait Until Element Is Visible        ${modal}                     5 seconds
                Click Button                         ${locator_msg_Alert}
                Wait Until Element Is Not Visible    ${modal}    10 seconds
                Element Should Not Be Visible        ${modal}
        END
    END
    Close Browser

Verify Error Message Login - Fail            
    [Documentation]    สร้างตัวแปรเพื่อนำไปตรวจสอบ Error Message Login
    [Arguments]    ${locator}     ${errormsg}
    ${txt}=        Get Text       ${locator}
    Should Be Equal As Strings    ${txt}    ${errormsg}


Verify Input User And Password Login - Pass
    [Documentation]    ตรวจสอบการเข้าสู่ระบบ
    Open Test Master
    Wait Until Page Contains                Test- Master
    Input Text      ${locator_inputUser}    admin
    Input Text      ${locator_inputPass}    Password
    Click Button    ${locator_btnLogin}
    Wait Until Element Is Visible           ${locator_User}


Verify Check Log Out - Pass
    [Documentation]    ตรวจสอบการออกจากระบบ
    Click Element      ${locator_User}
    Click Element      ${locator_Logout}
    Wait Until Page Contains                 Test- Master 


Login User And Password 12366
    [Documentation]    ตรวจสอบการเข้าสู่ระบบของ User 12366 ผู้ใช้งาน
    Open Test Master
    Wait Until Page Contains                Test- Master
    Input Text      ${locator_inputUser}    12366
    Input Text      ${locator_inputPass}    Password
    Click Button    ${locator_btnLogin}
    Wait Until Element Is Visible           ${locator_User}
    
Login User And Password 12348
    [Documentation]    ตรวจสอบการเข้าสู่ระบบของ User 12348 หัวหน้าแผนก
    Open Test Master
    Wait Until Page Contains                Test- Master
    Input Text      ${locator_inputUser}    12348
    Input Text      ${locator_inputPass}    Password
    Click Button    ${locator_btnLogin}
    Wait Until Element Is Visible           ${locator_User}

Login User And Password 12349
    [Documentation]    ตรวจสอบการเข้าสู่ระบบของ User 12349 ผู้ใช้งานDCC
    Open Test Master
    Wait Until Page Contains                Test- Master
    Input Text      ${locator_inputUser}    12349
    Input Text      ${locator_inputPass}    Password
    Click Button    ${locator_btnLogin}
    Wait Until Element Is Visible           ${locator_User}

Login User And Password 12318
    [Documentation]    ตรวจสอบการเข้าสู่ระบบของ User 12318 ตัวแทนฝ่าย
    Open Test Master
    Wait Until Page Contains                Test- Master
    Input Text      ${locator_inputUser}    12318
    Input Text      ${locator_inputPass}    Password
    Click Button    ${locator_btnLogin}
    Wait Until Element Is Visible           ${locator_User}

Check Alert Error Border
    [Documentation]    ตรวจสอบกรอบแจ้งเตือนสีแดง สามารถใช้ได้กับทุกเมนู
    [Arguments]    ${locator_error}
    # ดึงค่า style ของฟิลด์
    ${style}=    Get Element Attribute    ${locator_error}    style

Check Alert
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp
    [Arguments]                           ${text1}              ${text2}
    ${swal2-title}=      Get Text         ${locator_Alert}
    Should Be Equal As Strings            ${swal2-title}        ${text1} 

    ${swal2-content}=    Get Text         ${locator_Alert2}
    Should Be Equal As Strings            ${swal2-content}      ${text2} 


Check Alert Ok
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp คลิกตกลง
    [Arguments]                           ${text}
    ${swal2-title}=    Get Text           ${locator_Alert}
    Should Be Equal As Strings            ${swal2-title}      ${text} 
    Click Element    ${locator_ok_alert}
     
Check Alert Cancle
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp คลิกยกเลิก
    [Arguments]                           ${text}
    ${swal2-title}=    Get Text           ${locator_Alert}
    Should Be Equal As Strings            ${swal2-title}      ${text} 
    Click Element    ${locator_cancle_alert}

Check Alert Ok 2
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp คลิกตกลง
    [Arguments]                           ${text}
    ${swal2-title}=    Get Text           ${locator_Alert}
    Should Be Equal As Strings            ${swal2-title}      ${text} 
    Click Element    ${locator_ok_alert2}
     
Check Alert Cancle 2
    [Documentation]    ตรวจสอบแจ้งเตือนที่เป็น PopUp คลิกยกเลิก
    [Arguments]                           ${text}
    ${swal2-title}=    Get Text           ${locator_Alert}
    Should Be Equal As Strings            ${swal2-title}      ${text} 
    Click Element    ${locator_cancle_alert2}





