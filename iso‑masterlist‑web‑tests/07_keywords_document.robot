***Settings***
Library    SeleniumLibrary
Library     OperatingSystem
Resource    ${CURDIR}/00_variables.robot
Resource    ${CURDIR}/05_keywords_common.robot

***Keywords***
#ประเภทเอกสาร
Open Document Type
    [Documentation]       ตรวจสอบการเปิดข้อมูลประเภทเอกสาร
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_setting_Document} 
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_document_Doctype}
    Wait Until Page Contains                          ประเภทเอกสาร

Verify Search Filters Document Type - Pass
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    Open Document Type
    [Arguments]        ${id}         ${nameth}            ${nameen}                        ${sataus}
    Input Text         ${locator_docsearch_Idtype}        ${id}
    Input Text         ${locator_docsearch_Namethtype}    ${nameth}
    Input Text         ${locator_docsearch_Nameentype}    ${nameen}

    IF                "${sataus}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_docsearch_Statustype}       -1
    ELSE IF           "${sataus}" == "ปกติ"
            Select From List By Value                   ${locator_docsearch_Statustype}       1
    ELSE IF           "${sataus}" == "ระงับการใช้งาน"  
            Select From List By Value                   ${locator_docsearch_Statustype}       0
    END
    
    Click Element                                       ${locator_btn_docsearch}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_Doctype}              2         ${id}
    Table Column Should Contain                         ${locator_table_Doctype}              3         ${nameth}
    Table Column Should Contain                         ${locator_table_Doctype}              4         ${nameen}
    Table Column Should Contain                         ${locator_table_Doctype}              6         ${sataus}

Verify clear Filters Document Type - Pass
    [Documentation]    ตรวจสอบการคลิกปุ่มเคลียร์ และเช็คว่าฟีลด์เป็นค่าว่าง
    Click Element                      ${locator_btnclear_docsearch}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Value                          ${locator_docsearch_Idtype}
    Should Be Empty                    ${locator_search_Id_value}

    ${locator_search_Name_value}=      Get Value                          ${locator_docsearch_Namethtype}
    Should Be Empty                    ${locator_search_Name_value} 
    
    ${locator_search_Name_value}=      Get Value                          ${locator_docsearch_Nameentype}
    Should Be Empty                    ${locator_search_Name_value}

    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าเริ่มต้น
    ${locator_select_status_value}=    Get Selected List Value            ${locator_docsearch_Statustype}
    Should Be Equal                    ${locator_select_status_value}     -1

Add Document Type
    [Documentation]    ใช้สำหรับกรอกข้อมูล เพิ่ม-ประเภทเอกสาร
    Open Document Type
    Click Element      ${locator_add_Doctype}
    Wait Until Element Is Visible                    ${locator_btn_save}
    [Arguments]        ${id}      ${nameth}          ${nameen}    ${depart}    ${ciso}    ${ceo}
    Input Text         ${locator_add_idtype}         ${id}
    Input Text         ${locator_add_namethtype}     ${name_th}
    Input Text         ${locator_add_nameentype}     ${name_en}

    IF                "${depart}" == "QMR"    
            Select From List By Value                   ${locator_add_detype}           1
    ELSE IF           "${depart}" == "EMR"
            Select From List By Value                   ${locator_add_detype}           2
    END

    IF                "${ciso}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_cisotype}          0
    ELSE IF           "${ciso}" == "yes"
            Select From List By Value                   ${locator_add_cisotype}          1
    END

    IF                "${ceo}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_ceotype}           0
    ELSE IF           "${ceo}" == "yes"
            Select From List By Value                   ${locator_add_ceotype}           1
    END

    Click Element      ${locator_btn_save}

    IF                "${id}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_idtype}
    END 

    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END

Delete Document Type
    [Documentation]    ใช้สำหรับลบประเภทเอกสาร
    Wait Until Element Is Visible        ${locator_delete_doctype}
    Click Element                        ${locator_delete_doctype}
    Check Alert Cancle                   ยืนยัน!
    Click Element                        ${locator_delete_doctype}
    Check Alert Ok                       ยืนยัน!
    Check Alert                          ลบข้อมูลสำเร็จ!    ${EMPTY}
    Wait Until Page Contains             ประเภทเอกสาร
    Close Browser

Edit Add Document Type
    [Documentation]    ใช้สำหรับแก้ไข รายละเอียด-ประเภทเอกสาร
    Click Element      ${locator_edit_btndoctype}
    Wait Until Element Is Visible                    ${locator_btn_save}
    [Arguments]        ${nameth}    ${nameen}        ${depart}    ${ciso}    ${ceo}
    Input Text         ${locator_add_namethtype}     ${name_th}
    Input Text         ${locator_add_nameentype}     ${name_en}

    IF                "${depart}" == "QMR"    
            Select From List By Value                   ${locator_add_detype}           1
    ELSE IF           "${depart}" == "EMR"
            Select From List By Value                   ${locator_add_detype}           2
    END

    IF                "${ciso}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_cisotype}          0
    ELSE IF           "${ciso}" == "yes"
            Select From List By Value                   ${locator_add_cisotype}          1
    END

    IF                "${ceo}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_ceotype}           0
    ELSE IF           "${ceo}" == "yes"
            Select From List By Value                   ${locator_add_ceotype}           1
    END

    Click Element      ${locator_btn_save}
    
    IF                "${nameth}" != "${EMPTY}"
           Check Alert                                  บันทึกข้อมูลสำเร็จ!    ${EMPTY}
    END
    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END


## ตั้งค่าเอกสาร / ระดับชั้นความลับ


Open Document Type Level
    [Documentation]       ตรวจสอบการเปิดข้อมูลระดับชั้นความลับ
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_setting_Document} 
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_document_DocLevel}
    Wait Until Page Contains                          ระดับชั้นความลับของเอกสาร

Add Document Type Level
    [Documentation]    ใช้สำหรับกรอกข้อมูล เพิ่ม-ประเภทเอกสาร
    Open Document Type Level
    Click Element      ${locator_add_doclevel}
    Wait Until Element Is Visible                    ${locator_btn_save}
    [Arguments]        ${id}      ${nameth}          ${nameen}              ${approv}
    Input Text         ${locator_add_idtype}         ${id}
    Input Text         ${locator_add_namethtype}     ${name_th}
    Input Text         ${locator_add_nameentype}     ${name_en}

    IF                "${approv}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_doclevel_ap}           0
    ELSE IF           "${approv}" == "DCC"
            Select From List By Value                   ${locator_add_doclevel_ap}           1
    ELSE IF           "${approv}" == "ตัวแทนฝ่ายบริหาร"    
            Select From List By Value                   ${locator_add_doclevel_ap}           2
    ELSE IF           "${approv}" == "CISO"
            Select From List By Value                   ${locator_add_doclevel_ap}           3
    ELSE IF           "${approv}" == "CEO"    
            Select From List By Value                   ${locator_add_doclevel_ap}           4
    END

    Click Element      ${locator_btn_save}

    IF                "${id}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_idtype}
    END 

    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END

    IF                "${approv}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_doclevel_ap}
    END

    IF                "${id}" == "PUB"
           Check Alert                ${EMPTY}          รหัสระดับชั้นความลับ 'PUB' ซ้ำ! กรุณาตรวจสอบ.
    END

Verify Search Filters Document Type Level
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    Open Document Type Level
    [Arguments]        ${id}         ${nameth}            ${nameen}                        ${sataus}
    Input Text         ${locator_docsearch_Idtype}        ${id}
    Input Text         ${locator_docsearch_Namethtype}    ${nameth}
    Input Text         ${locator_docsearch_Nameentype}    ${nameen}

    IF                "${sataus}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_docsearch_Statustype}      -1
    ELSE IF           "${sataus}" == "ปกติ"
            Select From List By Value                   ${locator_docsearch_Statustype}       1
    ELSE IF           "${sataus}" == "ระงับการใช้งาน"  
            Select From List By Value                   ${locator_docsearch_Statustype}       0
    END
    
    Click Element                                       ${locator_btn_docsearch}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_Doctype}              2         ${id}
    Table Column Should Contain                         ${locator_table_Doctype}              3         ${nameth}
    Table Column Should Contain                         ${locator_table_Doctype}              4         ${nameen}
    Table Column Should Contain                         ${locator_table_Doctype}              7         ${sataus}

Verify clear Filters Document Type Level
    [Documentation]    ตรวจสอบการคลิกปุ่มเคลียร์ และเช็คว่าฟีลด์เป็นค่าว่าง
    Click Element                      ${locator_btnclear_docsearch}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Value                          ${locator_docsearch_Idtype}
    Should Be Empty                    ${locator_search_Id_value}

    ${locator_search_Name_value}=      Get Value                          ${locator_docsearch_Namethtype}
    Should Be Empty                    ${locator_search_Name_value} 
    
    ${locator_search_Name_value}=      Get Value                          ${locator_docsearch_Nameentype}
    Should Be Empty                    ${locator_search_Name_value}

    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าเริ่มต้น
    ${locator_select_status_value}=    Get Selected List Value            ${locator_docsearch_Statustype}
    Should Be Equal                    ${locator_select_status_value}     -1

# Delete Document Type Level
#     [Documentation]    ใช้สำหรับลบระดับชั้นความลับ
#     Wait Until Element Is Visible        ${locator_delete_doctype}
#     Click Element                        ${locator_delete_doctype}
#     Check Alert Cancle                   ยืนยัน!
#     Click Element                        ${locator_delete_doctype}
#     Check Alert Ok                       ยืนยัน!
#     Check Alert                          ลบข้อมูลสำเร็จ!    ${EMPTY}
#     Wait Until Page Contains             ประเภทเอกสาร
#     Close Browser

Edit Add Document Type Level
    [Documentation]    ใช้สำหรับแก้ไข รายละเอียด-ระดับชั้นความลับ
    Click Element      ${locator_btn_editdoclevel}
    Wait Until Element Is Visible                       ${locator_btn_save}
    [Arguments]        ${nameth}                        ${status}              ${approv}    
    Input Text         ${locator_add_namethtype}        ${name_th}

    IF                "${approv}" == "${EMPTY}"    
            Select From List By Value                   ${locator_add_doclevel_ap}           0
    ELSE IF           "${approv}" == "DCC"
            Select From List By Value                   ${locator_add_doclevel_ap}           1
    ELSE IF           "${approv}" == "ตัวแทนฝ่ายบริหาร"    
            Select From List By Value                   ${locator_add_doclevel_ap}           2
    ELSE IF           "${approv}" == "CISO"
            Select From List By Value                   ${locator_add_doclevel_ap}           3
    ELSE IF           "${approv}" == "CEO"    
            Select From List By Value                   ${locator_add_doclevel_ap}           4
    END

    IF                "${status}" == "ระงับการใช้งาน"    
            Select From List By Value                   ${locator_add_Rolestatusli}           0
    ELSE IF           "${status}" == "ปกติ"
            Select From List By Value                   ${locator_add_Rolestatusli}           1
    END

    Click Element      ${locator_btn_save}


    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END

    IF                "${approv}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_doclevel_ap}
    END



## ตั้งค่าเอกสาร / ความถี่การรีวิวเอกสาร


Open Document Review
    [Documentation]       ตรวจสอบการเปิดข้อมูลความถี่การรีวิวเอกสาร
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_setting_Document} 
    Wait Until Element Is Visible                     ${locator_document_Review}
    Click Element         ${locator_document_Review}
    Wait Until Element Is Visible                     ${locator_add_docReview}    
            
Add Document Review
    [Documentation]    ใช้สำหรับกรอกข้อมูล เพิ่ม-ประเภทเอกสาร
    Open Document Review
    Click Element      ${locator_add_docReview}
    Wait Until Element Is Visible                      ${locator_btn_save}
    [Arguments]        ${id}      ${nameth}                       
    Input Text         ${locator_add_idtype}           ${id}
    Input Text         ${locator_add_namethtype}       ${name_th}

    Click Element      ${locator_btn_save}

    IF                "${id}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_idtype}
    END 

    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END

    IF                "${id}" == "6-month"
           Check Alert            ${EMPTY}               รหัสความถี่การรีวิวเอกสาร '6-month' ซ้ำ! กรุณาตรวจสอบ.
           Click Element          ${locator_Close}
    ELSE IF           "${id}" != "${EMPTY}"
           Check Alert            เพิ่มข้อมูลสำเร็จ!          ${EMPTY}
    END 

    Close Browser


Verify Search Filters Document Review
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    Open Document Review
    [Arguments]        ${id}         ${nameth}            ${sataus}
    Input Text         ${locator_docsearch_Idtype}        ${id}
    Input Text         ${locator_docsearch_Namethtype}    ${nameth}

    IF                "${sataus}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_docsearch_Statustype}      -1
    ELSE IF           "${sataus}" == "ปกติ"
            Select From List By Value                   ${locator_docsearch_Statustype}       1
    ELSE IF           "${sataus}" == "ระงับการใช้งาน"  
            Select From List By Value                   ${locator_docsearch_Statustype}       0
    END
    
    Click Element                                       ${locator_btn_docsearch}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_Doctype}              2         ${id}
    Table Column Should Contain                         ${locator_table_Doctype}              3         ${nameth}
    Table Column Should Contain                         ${locator_table_Doctype}              6         ${sataus}


Edit Add Document Review
    [Documentation]    ใช้สำหรับแก้ไข รายละเอียด-ประเภทเอกสาร
    Click Element      ${locator_btn_editReview}
    Wait Until Element Is Visible                       ${locator_btn_save}
    [Arguments]        ${nameth}                        ${status}    
    Input Text         ${locator_add_namethtype}        ${name_th}

    IF                "${status}" == "ระงับการใช้งาน"    
            Select From List By Value                   ${locator_add_Rolestatusli}           0
    ELSE IF           "${status}" == "ปกติ"
            Select From List By Value                   ${locator_add_Rolestatusli}           1
    END

    Click Element      ${locator_btn_save}


    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END
    Close Browser

## ตั้งค่าเอกสาร / ระยะเวลาในการจัดเก็บเอกสาร
Open Document Time
    [Documentation]       ตรวจสอบการเปิดข้อมูลระยะเวลาในการจัดเก็บเอกสาร
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_setting_Document} 
    Wait Until Element Is Visible                     ${locator_document_time}
    Click Element         ${locator_document_time}
    Wait Until Element Is Visible                     ${locator_add_docReview}

Add Document Time
    [Documentation]    ใช้สำหรับกรอกข้อมูล เพิ่ม-ระยะเวลาในการจัดเก็บเอกสาร
    Open Document Time
    Click Element      ${locator_add_docReview}
    Wait Until Element Is Visible                      ${locator_btn_save}
    [Arguments]        ${id}      ${nameth}                       
    Input Text         ${locator_add_idtype}           ${id}
    Input Text         ${locator_add_namethtype}       ${name_th}

    Click Element      ${locator_btn_save}

    IF                "${id}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_idtype}
    END 

    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END

    IF                "${id}" == "1-year"
           Check Alert            ${EMPTY}               รหัสระยะเวลาในการจัดเก็บ '${id}' ซ้ำ! กรุณาตรวจสอบ.
           Click Element          ${locator_Close}
    ELSE IF           "${id}" != "${EMPTY}"
           Check Alert            เพิ่มข้อมูลสำเร็จ!          ${EMPTY}
    END 

    Close Browser

Verify Search Filters Document Time
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    Open Document Time
    [Arguments]        ${id}         ${nameth}            ${sataus}
    Input Text         ${locator_docsearch_Idtype}        ${id}
    Input Text         ${locator_docsearch_Namethtype}    ${nameth}

    IF                "${sataus}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_docsearch_Statustype}      -1
    ELSE IF           "${sataus}" == "ปกติ"
            Select From List By Value                   ${locator_docsearch_Statustype}       1
    ELSE IF           "${sataus}" == "ระงับการใช้งาน"  
            Select From List By Value                   ${locator_docsearch_Statustype}       0
    END
    
    Click Element                                       ${locator_btn_docsearch}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_Doctype}              2         ${id}
    Table Column Should Contain                         ${locator_table_Doctype}              3         ${nameth}
    Table Column Should Contain                         ${locator_table_Doctype}              6         ${sataus}

Edit Add Document Time
    [Documentation]    ใช้สำหรับแก้ไข รายละเอียด-ประเภทเอกสาร
    Click Element      ${locator_edit_btndoctype}
    Wait Until Element Is Visible                       ${locator_btn_save}
    [Arguments]        ${nameth}                        ${status}    
    Input Text         ${locator_add_namethtype}        ${name_th}

    IF                "${status}" == "ระงับการใช้งาน"    
            Select From List By Value                   ${locator_add_Rolestatusli}           0
    ELSE IF           "${status}" == "ปกติ"
            Select From List By Value                   ${locator_add_Rolestatusli}           1
    END

    Click Element      ${locator_btn_save}


    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    ELSE IF           "${nameth}" != "${EMPTY}"
           Check Alert                บันทึกข้อมูลสำเร็จ!    ${EMPTY}
    END 
    Close Browser

Delete Add Document Time
    [Documentation]    ใช้สำหรับลบระยะเวลาในการจัดเก็บเอกสาร
    Wait Until Element Is Visible        ${locator_delete_doctype}
    Click Element                        ${locator_delete_doctype}
    Check Alert Cancle                   ยืนยัน!
    Click Element                        ${locator_delete_doctype}
    Check Alert Ok                       ยืนยัน!
    Check Alert                          ลบข้อมูลสำเร็จ!    ${EMPTY}
    Wait Until Page Contains             ประเภทเอกสาร
    Close Browser


## ตั้งค่าเอกสาร / เอกสารสอดคล้องกับระบบ

Open Document System
    [Documentation]       ตรวจสอบการเปิดข้อมูลเอกสารสอดคล้องกับระบบ
    Open Test Master
    Verify Input User And Password Login - Pass
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                     ${locator_setting_Document}
    Click Element         ${locator_setting_Document} 
    Wait Until Element Is Visible                     ${locator_document_System}
    Click Element         ${locator_document_System}
    Wait Until Element Is Visible                     ${locator_add_docReview}

Add Document System
    [Documentation]    ใช้สำหรับกรอกข้อมูล เพิ่ม-เอกสารสอดคล้องกับระบบ
    Open Document System
    Click Element      ${locator_add_docReview}
    Wait Until Element Is Visible                      ${locator_btn_save}
    [Arguments]        ${id}      ${nameth}                       
    Input Text         ${locator_add_idtype}           ${id}
    Input Text         ${locator_add_namethtype}       ${name_th}

    Click Element      ${locator_btn_save}

    IF                "${id}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_idtype}
    END 

    IF                "${nameth}" == "${EMPTY}"
           Check Alert Error Border                     ${locator_add_namethtype}
    END

    IF                "${id}" == "Test"
           Check Alert            ${EMPTY}               รหัสเอกสารสอดคล้องกับระบบ '${id}' ซ้ำ! กรุณาตรวจสอบ.
           Click Element          ${locator_Close}
    ELSE IF           "${id}" != "${EMPTY}"
           Check Alert            เพิ่มข้อมูลสำเร็จ!          ${EMPTY}
    END 
    Close Browser

Verify Search Filters Document System
    [Documentation]    ใช้สำหรับการค้นหา และตรวจสอบผลลัพน์ในตาราง
    Open Document System
    [Arguments]        ${id}         ${nameth}            ${sataus}
    Input Text         ${locator_docsearch_Idtype}        ${id}
    Input Text         ${locator_docsearch_Namethtype}    ${nameth}

    IF                "${sataus}" == "ทั้งหมด"    
            Select From List By Value                   ${locator_docsearch_Statustype}      -1
    ELSE IF           "${sataus}" == "ปกติ"
            Select From List By Value                   ${locator_docsearch_Statustype}       1
    ELSE IF           "${sataus}" == "ระงับการใช้งาน"  
            Select From List By Value                   ${locator_docsearch_Statustype}       0
    END
    
    Click Element                                       ${locator_btn_docsearch}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Table Column Should Contain                         ${locator_table_Doctype}              2         ${id}
    Table Column Should Contain                         ${locator_table_Doctype}              3         ${nameth}
    Table Column Should Contain                         ${locator_table_Doctype}              6         ${sataus}

