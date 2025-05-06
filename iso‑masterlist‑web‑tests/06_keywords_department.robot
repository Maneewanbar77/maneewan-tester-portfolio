***Settings***
Library    SeleniumLibrary
Library     OperatingSystem
Resource    ${CURDIR}/00_variables.robot
Resource    ${CURDIR}/05_keywords_common.robot


***Keywords***
#แผนก
Open Department
    [Documentation]    ตรวจสอบการเปิดข้อมูลหน้าแผนก
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element                    ${locator_Menu}
    Wait Until Element Is Visible    ${locator_setting_System}
    Click Element                    ${locator_setting_System}
    Wait Until Element Is Visible    ${locator_system_Department} 
    Click Element                    ${locator_system_Department}
    Wait Until Page Contains         แผนก

Button Add Department
    [Documentation]    ใช้คลิกปุ่มเพิ่ม เพื่อเปิดหน้า เพิ่ม-แผนก
    Click Element                    ${locator_Department_Add}
    ${modal}=    Get WebElement      ${locator_popup_Addepartment} 
    Wait Until Element Is Visible    ${modal}                 1 seconds



Verify Add Department - Pass
    [Documentation]    ใช้สำหรับกรอกข้อมูลหน้า เพิ่ม-แผนก
    # Verify Input User And Password Login - Pass
    Open Department
    Button Add Department
    [Arguments]        ${id}                          ${name_th}        
    Input Text         ${locator_add_Iddepart}        ${id}
    Input Text         ${locator_add_namedepartTh}    ${name_th}
    # Input Text       ${locator_add_namedepartEn}    ${name_en}
    Click Element      ${locator_add_Btndepart}
    # Check Alert        บันทึกข้อมูลสำเร็จ!    ${EMPTY}    


Verify Add Department - Fail
    [Documentation]    ใช้สำหรับกรอกข้อมูลหน้า เพิ่ม-แผนก Fail
    [Arguments]        ${id}       ${name_th}     
    # Verify Input User And Password Login - Pass
    Open Department
    Button Add Department    
    Input Text         ${locator_add_Iddepart}        ${id}
    Input Text         ${locator_add_namedepartTh}    ${name_th}
    Click Element      ${locator_add_Btndepart}

    IF     "${id}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_add_Iddepart}
    END

    IF    "${name_th}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_add_namedepartTh}
    END

    Close Browser


Verify Search Filters Department - Pass
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    [Arguments]    ${id}    ${nameth}       ${role}
    Open Department
    Input Text    ${locator_search_Id}      ${id}
    Input Text    ${locator_search_Name}    ${nameth}

    IF           "${role}" == "ทั้งหมด"
            Select From List By Value       ${locator_select_status}    -1
    ELSE IF      "${role}" == "ปกติ"
            Select From List By Value       ${locator_select_status}     1
    ELSE IF      "${role}" == "ระงับการใช้งาน"
            Select From List By Value       ${locator_select_status}     0
    END
    
    Click Element                           ${locator_search_btn}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง           column ที่ต้องการเช็ค
    Table Column Should Contain    ${locator_table_Department}    2      ${id}
    Table Column Should Contain    ${locator_table_Department}    3      ${nameth}
    Table Column Should Contain    ${locator_table_Department}    6      ${role}


Verify clear Filters Department - Pass
    [Documentation]    ตรวจสอบการคลิกปุ่มเคลียร์ และเช็คว่าฟีลด์เป็นค่าว่าง
    Click Element      ${locator_search_clear}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Value                      ${locator_search_Id}
    Should Be Empty                    ${locator_search_Id_value}

    ${locator_search_Name_value}=      Get Value                      ${locator_search_Name}
    Should Be Empty                    ${locator_search_Name_value}

    ${locator_search_Id_value}=        Get Value                      ${locator_search_Id}
    Should Be Empty                    ${locator_search_Id_value}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าเริ่มต้น
    ${locator_select_status_value}=    Get Selected List Value        ${locator_select_status}
    Should Be Equal                    ${locator_select_status_value}    -1


Verify Edit Department - Pass
    [Documentation]    ใช้สำหรับแก้ไขแผนก
    Click Element      ${locator_edit_Department}
    Wait Until Page Contains                           รายละเอียด-แผนก
    [Arguments]        ${edittxt}
    Input Text         ${locator_edit_namedepartTh}    ${edittxt}
    Click Element      ${locator_add_Btndepart}
    Check Alert        บันทึกข้อมูลสำเร็จ!    ${EMPTY}
    Close Browser


Verify Delete Department - Pass
    [Documentation]    ใช้สำหรับตรวจสอบการลบข้อมูลแผนก
    Click Element      ${locator_delete_Department}
    Check Alert Cancle    ยืนยัน!
    Click Element         ${locator_delete_Department}
    Check Alert Ok        ยืนยัน!
    Check Alert           ลบข้อมูลสำเร็จ!    ${EMPTY}


#สิทธิ์การใช้งาน

Open License
    [Documentation]       ตรวจสอบการเปิดข้อมูลสิทธิ์การใช้งาน
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_System}
    Click Element         ${locator_setting_System} 
    Wait Until Element Is Visible                     ${locator_system_License}
    Click Element         ${locator_system_License}
    Wait Until Page Contains                          สิทธิ์การใช้งาน

Button Add License
    [Documentation]       ใช้คลิกปุ่มเพิ่ม เพื่อเปิดหน้า เพิ่มสิทธิ์การใช้งาน
    Click Element         ${locator_license_Add}
    Wait Until Page Contains Element                  ${locator_add_Idlicense}
    
Verify System Add License - Pass
    [Documentation]       ใช้สำหรับกรอกข้อมูล เพิ่มสิทธิ์การใช้งาน - Pass
    Open License
    Button Add License
    [Arguments]      ${id}        ${name_th}         ${name_en}           ${role}       ${status}
    Input Text       ${locator_add_Idlicense}        ${id}
    Input Text       ${locator_add_namelicenseTh}    ${name_th}
    Input Text       ${locator_add_namelicenseEn}    ${name_en}
    # Click Element    ${locator_add_Btnlicense}
    
    IF              "${role}" == "-- เลือกระดับสิทธิ์ --"
            Select From List By Value                ${locator_add_Rolelicense}         0
    ELSE IF         "${role}" == "User"
            Select From List By Value                ${locator_add_Rolelicense}         3
    END
    
    IF              "${status}" == "ปกติ"
            Select From List By Value                ${locator_add_Rolestatusli}        1
    ELSE IF         "${status}" == "ระงับการใช้งาน"
            Select From List By Value                ${locator_add_Rolestatusli}        0
    END  

    Click Element    ${locator_add_Btnlicense}
    Check Alert      เพิ่มข้อมูลสำเร็จ!                   ${EMPTY}

Verify System Add License - Fail
    [Documentation]    ใช้สำหรับกรอกข้อมูลหน้า เพิ่ม-สิทธิ์การใช้งาน Fail
    [Arguments]        ${id}        ${name_th}        ${name_en}    ${role}    ${status}
    Open License
    Button Add License
    Input Text        ${locator_add_Idlicense}        ${id}
    Input Text        ${locator_add_namelicenseTh}    ${name_th}
    Input Text        ${locator_add_namelicenseEn}    ${name_en}
    
    IF               "${id}" == "${EMPTY}"
        Check Alert Error Border                      ${locator_add_Idlicense}
    END

    IF               "${name_th}" == "${EMPTY}"
        Check Alert Error Border                      ${locator_add_namelicenseTh}
    END
    
    IF               "${role}" == "-- เลือกระดับสิทธิ์ --" 
            Select From List By Value                 ${locator_add_Rolelicense}     0
    ELSE IF          "${role}" == "User"
            Select From List By Value                 ${locator_add_Rolelicense}     3
    END
    
    IF               "${status}" == "ปกติ"
            Select From List By Value                 ${locator_add_Rolestatusli}     1
    ELSE IF          "${status}" == "ระงับการใช้งาน"
            Select From List By Value                 ${locator_add_Rolestatusli}     0
    END

    Click Element     ${locator_add_Btnlicense} 
    Check Alert       ${EMPTY}    สิทธิ์การใช้งานซ้ำ! กรุณาตรวจสอบ
    # Close Browser

Verify Search Filters License - Pass
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    [Arguments]        ${id}        ${nameth}          ${role}
    Input Text         ${locator_search_Idlicense}      ${id}
    Input Text         ${locator_search_Namelicense}    ${nameth}

    IF                "${role}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_search_Rolelicense}     0
    ELSE IF           "${role}" == "User"
            Select From List By Value                   ${locator_search_Rolelicense}     3
    END
    
    Click Element                                       ${locator_search_Btnlicense}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_license}          2        ${id}
    Table Column Should Contain                         ${locator_table_license}          3        ${nameth}
    Table Column Should Contain                         ${locator_table_license}          7        ปกติ

Verify clear Filters License - Pass
    [Documentation]    ตรวจสอบการคลิกปุ่มเคลียร์ และเช็คว่าฟีลด์เป็นค่าว่าง
    Click Element                      ${locator_search_clearlicense} 
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Value                          ${locator_search_Idlicense}
    Should Be Empty                    ${locator_search_Id_value}

    ${locator_search_Name_value}=      Get Value                          ${locator_search_Namelicense}
    Should Be Empty                    ${locator_search_Name_value} 

    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าเริ่มต้น
    ${locator_select_status_value}=    Get Selected List Value            ${locator_search_Rolelicense}
    Should Be Equal                    ${locator_select_status_value}     0

Verify Edit license - Pass
    [Documentation]    ใช้สำหรับแก้ไขสิทธิ์การใช้งาน

    Click Element      ${locator_edit_license}
    Wait Until Page Contains                           รายละเอียดสิทธิ์การใช้งาน
    [Arguments]        ${id}        ${name_th}         ${name_en}           ${role}       ${status}
    Input Text         ${locator_add_Idlicense}        ${id}
    Input Text         ${locator_add_namelicenseTh}    ${name_th}
    Input Text         ${locator_add_namelicenseEn}    ${name_en}

    IF                "${role}" == "-- เลือกระดับสิทธิ์ --"
            Select From List By Value                  ${locator_add_Rolelicense}         0
    ELSE IF           "${role}" == "User"
            Select From List By Value                  ${locator_add_Rolelicense}         3
    END
    
    IF                "${status}" == "ปกติ"
            Select From List By Value                  ${locator_add_Rolestatusli}        1
    ELSE IF           "${status}" == "ระงับการใช้งาน"
            Select From List By Value                  ${locator_add_Rolestatusli}        0
    END  

    Click Element      ${locator_add_Btnlicense}
    Check Alert        บันทึกข้อมูลสำเร็จ!                  ${EMPTY}

Verify Edit license - Fail
    [Documentation]    ใช้สำหรับตรวจสอบแก้ไขสิทธิ์การใช้งานซ้ำ
    Check Alert                   สิทธิ์การใช้งานซ้ำ! กรุณาตรวจสอบ      ${EMPTY}


##สิทธิ์การใช้งาน / รายละเอียดฟังก์ชันการทำงาน
Verify Function license - Add
    [Documentation]    ใช้สำหรับการเลือกฟังก์ชัน

    #คลิกเพื่อเปิดรายละเอียดฟังก์ชันการทำงาน
    Click Element    ${locator_btn_functionli}
    #ครอจนกว่ารายละเอียดฟังก์ชันการทำงานจะปรากฎ
    Wait Until Page Contains          รายละเอียดฟังก์ชันการทำงาน
    [Arguments]      ${level}
    Wait Until Element Is Visible    ${locator_selectad_outfunctionli}
    # กำหนดตัวแปร ${value_level_select} มีค่าเริ่มต้นเป็น   0
    ${value_level_select} =    Set Variable          0

    # ตรวจสอบค่าของ ${level} และกำหนดค่า ${value_level_select} ตามค่าที่ได้รับ
    IF                "${level}" == "ประเภทเอกสาร"
        ${value_level_select} =      Set Variable    8
    ELSE IF           "${level}" == "จัดทำเอกสาร"
        ${value_level_select} =      Set Variable    14
    END
    
    # เลือกค่าจาก dropdown list ที่มีตัวระบุ ${locator_level_doc} โดยใช้ค่าที่เก็บใน ${value_level_select}
    Select From List By Value        ${locator_selectad_outfunctionli}     ${value_level_select}
    Click Element                    ${locator_btnad_functionli}
    # รอจนกว่า element ที่เลือกจะไม่ปรากฏให้เห็นอีกต่อไป
    Wait Until Element Is Not Visible                                      xpath=//select[@id='selectListFunctionWithOutRole']/option[@value='${value_level_select}']
    # รอจนกว่า element ที่มีค่า ${value_level_select} จะปรากฏใน dropdown list
    Wait Until Element Is Visible                                          xpath=//select[@id='selectListFunctionWithInRole']/option[@value='${value_level_select}']
    Close Browser

Verify Function license - Delete
    [Documentation]    ใช้สำหรับการลบฟังก์ชัน
    #คลิกเพื่อเปิดรายละเอียดฟังก์ชันการทำงาน
    Click Element    ${locator_btn_functionli}
    #ครอจนกว่ารายละเอียดฟังก์ชันการทำงานจะปรากฎ
    Wait Until Page Contains          รายละเอียดฟังก์ชันการทำงาน
    [Arguments]      ${level}
    Wait Until Element Is Visible    ${locator_selectde_infunctionli}
    # กำหนดตัวแปร ${value_level_select} มีค่าเริ่มต้นเป็น   0
    ${value_level_select} =    Set Variable          0

    # ตรวจสอบค่าของ ${level} และกำหนดค่า ${value_level_select} ตามค่าที่ได้รับ
    IF                "${level}" == "ประเภทเอกสาร"
        ${value_level_select} =      Set Variable    8
    ELSE IF           "${level}" == "จัดทำเอกสาร"
        ${value_level_select} =      Set Variable    14
    END
    
    # เลือกค่าจาก dropdown list ที่มีตัวระบุ ${locator_level_doc} โดยใช้ค่าที่เก็บใน ${value_level_select}
    Select From List By Value        ${locator_selectde_infunctionli}     ${value_level_select}
    Click Element                    ${locator_btnde_functionli}
    # รอจนกว่า element ที่เลือกจะไม่ปรากฏให้เห็นอีกต่อไป
    Wait Until Element Is Not Visible                                     xpath=//select[@id='selectListFunctionWithInRole']/option[@value='${value_level_select}']
    # รอจนกว่า element ที่มีค่า ${value_level_select} จะปรากฏใน dropdown list
    Wait Until Element Is Visible                                         xpath=//select[@id='selectListFunctionWithOutRole']/option[@value='${value_level_select}']
    Close Browser


Verify Delete license - Pass
    [Documentation]       ใช้สำหรับตรวจสอบการลบข้อมูลสิทธิ์การใช้งาน
    Click Element         ${locator_delete_License}
    Check Alert Cancle    ยืนยัน!
    Click Element         ${locator_delete_License}
    Check Alert Ok        ยืนยัน!
    Check Alert           ลบข้อมูลสำเร็จ!    ${EMPTY}
    



##ผู้ใช้งาน 
Open User
    [Documentation]       ตรวจสอบการเปิดข้อมูลผู้ใช้งาน
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_System}
    Click Element         ${locator_setting_System} 
    Wait Until Element Is Visible                     ${locator_system_User}
    Click Element         ${locator_system_User}
    Wait Until Page Contains                          ผู้ใช้งาน

Verify Search Filters User - Pass
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    Open User
    [Arguments]        ${id}        ${nameth}          ${depart}                           ${sataus}
    Input Text         ${locator_search_Iduser}        ${id}
    Input Text         ${locator_search_Nameuser}      ${nameth}

    IF                "${depart}" == "IT Software"    
            Select From List By Value                   ${locator_search_Deuser}           37
    ELSE IF           "${depart}" == "ISO"
            Select From List By Value                   ${locator_search_Deuser}           19
    ELSE IF           "${depart}" == "ทั้งหมด"
            Select From List By Value                   ${locator_search_Deuser}           0
    END

    IF                "${sataus}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_search_Statususer}       0
    ELSE IF           "${sataus}" == "ปกติ"
            Select From List By Value                   ${locator_search_Statususer}       1
    ELSE IF           "${sataus}" == "ระงับการใช้งาน"  
            Select From List By Value                   ${locator_search_Statususer}       2
    END
    
    Click Element                                       ${locator_search_Btnuser}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_User}              4         ${id}
    Table Column Should Contain                         ${locator_table_User}              7         ${nameth}
    Table Column Should Contain                         ${locator_table_User}              9         ${depart}
    Table Column Should Contain                         ${locator_table_User}              11        ${sataus}

Verify clear Filters User - Pass
    [Documentation]    ตรวจสอบการคลิกปุ่มเคลียร์ และเช็คว่าฟีลด์เป็นค่าว่าง
    Click Element                      ${locator_search_clearuser}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Value                          ${locator_search_Iduser}
    Should Be Empty                    ${locator_search_Id_value}

    ${locator_search_Name_value}=      Get Value                          ${locator_search_Nameuser}
    Should Be Empty                    ${locator_search_Name_value} 

    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าเริ่มต้น
    ${locator_select_status_value}=    Get Selected List Value            ${locator_search_Deuser} 
    Should Be Equal                    ${locator_select_status_value}     0
    ${locator_select_status_value}=    Get Selected List Value            ${locator_search_Statususer}
    Should Be Equal                    ${locator_select_status_value}     0

Verify Edit User
    [Documentation]    ใช้สำหรับแก้ไขสิทธิ์การใช้งาน และเช็คกรอบแจ้งเตือน
    # Open User
    Verify Search Filters User - Pass    12366    มณีวรรณ    IT Software    ปกติ
    Click Element      ${locator_edit_user}
    Wait Until Page Contains             รายละเอียดผู้ใช้งาน
    [Arguments]        ${company}        ${name_com}        ${license}                    ${depart}          ${name_th}    ${last_th}
    Input Text         ${locator_edit_unameth}              ${name_th}
    Input Text         ${locator_edit_ulastth}              ${last_th}

    IF                "${company}" == "${EMPTY}"    
            Select From List By Value                   ${locator_edit_ucompany}           0
    ELSE IF           "${company}" == "company"
            Select From List By Value                   ${locator_edit_ucompany}           1
    END
    IF                "${name_com}" == "${EMPTY}"    
            Select From List By Value                   ${locator_edit_unamecom}           0
    ELSE IF           "${name_com}" == "CPN"
            Select From List By Value                   ${locator_edit_unamecom}           120403153323
    END
    IF                "${license}" == "${EMPTY}"    
            Select From List By Value                   ${locator_edit_ulicense}           0
    ELSE IF           "${license}" == "หัวหน้าแผนก"
            Select From List By Value                   ${locator_edit_ulicense}           7
    ELSE IF           "${license}" == "ผู้ใช้งาน"
            Select From List By Value                   ${locator_edit_ulicense}           8
    END
    IF                "${depart}" == "${EMPTY}"    
            Select From List By Value                   ${locator_edit_udepart}            ${EMPTY}
    ELSE IF           "${depart}" == "IT Software"
            Select From List By Value                   ${locator_edit_udepart}            ITS
    END

    Click Element      ${locator_btn_save}

    IF     "${company}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_edit_ucompany}
    END

    IF    "${name_com}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_edit_unamecom}
    END

    IF    "${license}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_edit_ulicense}
    END

    IF    "${depart}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_edit_udepart}
    END

    IF    "${name_th}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_edit_unameth}
    END

    IF    "${last_th}" == "${EMPTY}"
           Check Alert Error Border                   ${locator_edit_ulastth}
    END

Add License User
    [Documentation]    ใช้สำหรับเพิ่มสิทธิ์การใช้งาน 
    Verify Search Filters User - Pass    101670066    มณีวรรณ    IT Software    ปกติ
    Click Element      ${locator_btn_Userli}
    Wait Until Element Is Visible      ${locator_add_Usercom}
    [Arguments]        ${company}      ${depart}        ${license}

    IF                "${company}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_Usercom}           0
    ELSE IF           "${company}" == "จันทร์วาณิชย์"
            Select From List By Value                   ${locator_add_Usercom}           120403153323
    END

    IF                "${depart}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_Userde}           0
    ELSE IF           "${depart}" == "Card Perso"
            Select From List By Value                   ${locator_add_Userde}           CRD-PE
    ELSE IF           "${depart}" == "IT"
            Select From List By Value                   ${locator_add_Userde}           ITS
    END

    IF                "${license}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_Userli}           0
    ELSE IF           "${license}" == "หัวหน้าแผนก"
            Select From List By Value                   ${locator_add_Userli}           7
    ELSE IF           "${license}" == "ผู้ใช้งาน"
            Select From List By Value                   ${locator_add_Userli}           8
    END

    Click Element      ${locator_btn_addsave}

    IF                "${company}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_Usercom}
    END 

    IF                "${depart}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_Userde}
    END

    IF                "${license}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_Userli}
    END


Edit Add License User 
    [Documentation]    ใช้สำหรับแก้ไขการเพิ่มสิทธิ์การใช้งาน 
    # Add License User    จันทร์วาณิชย์    Card Perso    ผู้ใช้งาน
    # Check Alert    เพิ่มข้อมูลสำเร็จ!    ${EMPTY}
    Verify Search Filters User - Pass                   101670066    มณีวรรณ    IT Software    ปกติ
    Click Element      ${locator_btn_Userli}
    Wait Until Element Is Visible                       ${locator_add_Usercom}
    Click Element      ${locator_edit_btnuser}
    [Arguments]        ${company}      ${depart}        ${license}

    IF                "${company}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_Usercom}           0
    ELSE IF           "${company}" == "company"
            Select From List By Value                   ${locator_add_Usercom}           120403153323
    END

    IF                "${depart}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_Userde}            0
    ELSE IF           "${depart}" == "Card"
            Select From List By Value                   ${locator_add_Userde}            CRD-PE
    ELSE IF           "${depart}" == "IT" 
            Select From List By Value                   ${locator_add_Userde}            ITS
    END

    IF                "${license}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_Userli}            0
    ELSE IF           "${license}" == "หัวหน้าแผนก"
            Select From List By Value                   ${locator_add_Userli}            7
    ELSE IF           "${license}" == "ผู้ใช้งาน"
            Select From List By Value                   ${locator_add_Userli}            8
    END

    Click Element      ${locator_btn_addsave}

    IF                "${company}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_Usercom}
    END

    IF                "${depart}" == "${EMPTY}" 
           Check Alert Error Border                     ${locator_add_Userde}
    END

    IF                "${license}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_Userli}
    END

Clear Edit Add License User 
    [Documentation]    ใช้สำหรับเคลียร์ การแก้ไขสิทธิ์การใช้งาน
    Edit Add License User              company    Card      ${EMPTY}
    Click Element                      ${locator_edit_btnClear}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Selected List Value                             ${locator_add_Usercom}
    Should Be Equal                    ${locator_search_Id_value}    0
    ${locator_search_Id_value}=        Get Selected List Value                              ${locator_add_Userde}
    Should Be Equal                    ${locator_search_Id_value}    0
    ${locator_search_Id_value}=        Get Selected List Value                              ${locator_add_Userli}
    Should Be Equal                    ${locator_search_Id_value}    0
    Close Browser
  
Delete Add License User
    [Documentation]    ใช้สำหรับลบสิทธิ์การใช้งาน 
    Verify Search Filters User - Pass    101670066    มณีวรรณ    IT Software    ปกติ
    Click Element                        ${locator_btn_Userli}
    Wait Until Element Is Visible        ${locator_add_Usercom}
    Click Element                        ${locator_edit_btnDelete}
    Check Alert Cancle 2                 ยืนยันลบสิทธิ์การใช้งาน!
    Click Element                        ${locator_edit_btnDelete}
    Check Alert Ok 2                     ยืนยันลบสิทธิ์การใช้งาน!
    Check Alert                          ลบข้อมูลสำเร็จ!    ${EMPTY}
    Click Button                         ${locator_edit_btnclose}
    Wait Until Page Contains             ผู้ใช้งาน
    Close Browser

level document
    Verify Search Filters User - Pass    12366    มณีวรรณ    IT Software    ปกติ
    Click Element    ${locator_btn_level}
    Wait Until Page Contains         ระดับชั้นความลับของเอกสาร
    [Arguments]      ${level}
    Wait Until Element Is Visible    ${locator_level_doc}
    # กำหนดตัวแปร ${value_level_select} มีค่าเริ่มต้นเป็น   0
    ${value_level_select} =    Set Variable          0

    # ตรวจสอบค่าของ ${level} และกำหนดค่า ${value_level_select} ตามค่าที่ได้รับ
    IF                "${level}" == "ข้อมูลทั่วไป"
        ${value_level_select} =      Set Variable    1
    ELSE IF           "${level}" == "ข้อมูลใช้ภายใน"
        ${value_level_select} =      Set Variable    2
    ELSE IF           "${level}" == "ข้อมูลลับ"
        ${value_level_select} =      Set Variable    3
    ELSE IF           "${level}" == "ข้อมูลลับมาก"
        ${value_level_select} =      Set Variable    4
    END
    
    # เลือกค่าจาก dropdown list ที่มีตัวระบุ ${locator_level_doc} โดยใช้ค่าที่เก็บใน ${value_level_select}
    Select From List By Value        ${locator_level_doc}     ${value_level_select}
    Click Element                    ${locator_btn_levelad}
    # รอจนกว่า element ที่เลือกจะไม่ปรากฏให้เห็นอีกต่อไป
    Wait Until Element Is Not Visible                         xpath=//select[@id='documentLevel']/option[@value='${value_level_select}']
    # รอจนกว่า element ที่มีค่า ${value_level_select} จะปรากฏใน dropdown list
    Wait Until Element Is Visible                             xpath=//select[@id='documentLevelSelect']/option[@value='${value_level_select}']

level select document
    Verify Search Filters User - Pass    12366    มณีวรรณ    IT Software    ปกติ
    Click Element    ${locator_btn_level}
    Wait Until Page Contains         ระดับชั้นความลับของเอกสาร
    [Arguments]      ${level}
    Wait Until Element Is Visible    ${locator_level_docse}
    ${value_level_select} =    Set Variable          0
    IF                "${level}" == "ข้อมูลทั่วไป"
        ${value_level_select} =      Set Variable    1
    ELSE IF           "${level}" == "ข้อมูลใช้ภายใน"
        ${value_level_select} =      Set Variable    2
    ELSE IF           "${level}" == "ข้อมูลลับ"
        ${value_level_select} =      Set Variable    3
    ELSE IF           "${level}" == "ข้อมูลลับมาก"
        ${value_level_select} =      Set Variable    4
    END
    
    Select From List By Value        ${locator_level_docse}     ${value_level_select}
    Click Element                    ${locator_btn_levelde}
    Wait Until Element Is Not Visible                           xpath=//select[@id='documentLevelSelect']/option[@value='${value_level_select}']
    Wait Until Element Is Visible                               xpath=//select[@id='documentLevel']/option[@value='${value_level_select}']


Document System User Delete
    [Documentation]    ใช้สำหรับลบเอกสารที่มีสิทธิ์
    Verify Search Filters User - Pass    12366    มณีวรรณ    IT Software    ปกติ
    Click Element    ${locator_btn_levelsys}
    Wait Until Page Contains    เอกสารสอดคล้องกับระบบ

    [Arguments]      ${level}
    Wait Until Element Is Visible    ${locator_document_Secor}
    ${value_level_select} =    Set Variable          0

    IF                "${level}" == "ISO9001"
        ${value_level_select} =      Set Variable    1
    ELSE IF           "${level}" == "ISO14001"
        ${value_level_select} =      Set Variable    2
    ELSE IF           "${level}" == "ISO45001"
        ${value_level_select} =      Set Variable    3
    ELSE IF           "${level}" == "PDPA"
        ${value_level_select} =      Set Variable    9
    END
    
    Select From List By Value        ${locator_document_Secor}     ${value_level_select}
    Click Element                    ${locator_btnde_Secor}
    Wait Until Element Is Not Visible                              xpath=//select[@id='documentCorrespondSelect']/option[@value='${value_level_select}']
    Wait Until Element Is Visible                                  xpath=//select[@id='documentCorrespond']/option[@value='${value_level_select}']

Document System User
    [Documentation]    ใช้สำหรับลบเอกสารที่มีสิทธิ์
    Verify Search Filters User - Pass    12366    มณีวรรณ    IT Software    ปกติ
    Click Element    ${locator_btn_levelsys}
    Wait Until Page Contains    เอกสารสอดคล้องกับระบบ

    [Arguments]      ${level}
    Wait Until Element Is Visible    ${locator_document_Cor}
    ${value_level_select} =    Set Variable          0

    IF                "${level}" == "ISO9001"
        ${value_level_select} =      Set Variable    1
    ELSE IF           "${level}" == "ISO14001"
        ${value_level_select} =      Set Variable    2
    ELSE IF           "${level}" == "ISO45001"
        ${value_level_select} =      Set Variable    3
    ELSE IF           "${level}" == "PDPA"
        ${value_level_select} =      Set Variable    9
    END
    
    Select From List By Value        ${locator_document_Cor}     ${value_level_select}
    Click Element                    ${locator_btnde_Cor}
    Wait Until Element Is Not Visible                            xpath=//select[@id='documentCorrespond']/option[@value='${value_level_select}']
    Wait Until Element Is Visible                                xpath=//select[@id='documentCorrespondSelect']/option[@value='${value_level_select}']
