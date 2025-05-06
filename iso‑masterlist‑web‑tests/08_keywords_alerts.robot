***Settings***
Library           SeleniumLibrary
Library           Collections
Library           String
Library           Process
Library           OperatingSystem
Library           BuiltIn
Resource          ${CURDIR}/00_variables.robot
Resource          ${CURDIR}/05_keywords_common.robot
Resource          ${CURDIR}/07_keywords_document.robot

*** Keywords ***


Open Document 101670066
    [Documentation]    ตรวจสอบการเปิดข้อมูลหน้าแผนก ผู้ใช้งาน
    Login User And Password 12366
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                                  ${locator_manu_document}
    Click Element         ${locator_manu_document} 
    Wait Until Element Is Visible                                  ${locator_document}
    Click Element         ${locator_document}
    Wait Until Element Is Visible                                  ${locator_document_btnsearch}

Open Document 101610048
    [Documentation]    ตรวจสอบการเปิดข้อมูลหน้าแผนก หัวหน้าแผนก
    Login User And Password 12348
    Click Element         ${locator_Menu}
    Wait Until Element Is Visible                                  ${locator_manu_document}
    Click Element         ${locator_manu_document} 
    Wait Until Element Is Visible                                  ${locator_document}
    Click Element         ${locator_document}
    Wait Until Element Is Visible                                  ${locator_document_btnsearch}

Open Document 101610049
    [Documentation]    ตรวจสอบการเปิดข้อมูลหน้าแผนก ผู้ใช้งานDCC
    # ใช้ Execute JavaScript เพื่อการคลิกเข้าเมนู เพราะ User แต่ละเมนูนั้นเป็น xpath และ xpath เปลี่ยนค่าไปตาม User
    Login User And Password 12349
    Wait Until Element Is Visible                                  ${locator_manu_document}
    Execute JavaScript                                             document.querySelector('a[href="/CSP-ISOMasterList/Document/DocumentView"]').click()
    # ${menu_xpath}    Set Variable    //a[contains(., 'เอกสาร')]
    # Click Element    ${menu_xpath}
    # ${submenu_xpath}    Set Variable    //a[contains(., 'จัดทำเอกสาร')]
    # Click Element    ${submenu_xpath}
    Wait Until Element Is Visible                                  ${locator_document_btnsearch}
    

Open Document 101590718
    [Documentation]    ตรวจสอบการเปิดข้อมูลหน้าแผนก ตัวแทนฝ่าย
    Login User And Password 12318
    Wait Until Element Is Visible                                  ${locator_manu_document}
    Execute JavaScript                                             document.querySelector('a[href="/CSP-ISOMasterList/Document/DocumentView"]').click()
    Wait Until Element Is Visible                                  ${locator_document_btnsearch}  

#ขึ้นทะเบียนเอกสาร / กรอกข้อมูล
Add New Document
    [Documentation]    ใช้สำหรับกรอกข้อมูล ขึ้นทะเบียนเอกสารใหม่
    Open Document 101670066
    Wait Until Element Is Visible                                  ${locator_btn_newdoc}
    Wait Until Element Is Not Visible    id=loadingspinner2
    Click Element      ${locator_btn_newdoc}
    Wait Until Element Is Visible                                  ${locator_btn_save}
    [Arguments]        ${nameth}      ${type}    ${depart}         ${page}    ${level}    ${review}    ${time}    #${chkbox}    ${file1}    ${file2}          
    Input Text         ${locator_nameth_newdoc}                    ${nameth} 
    Input Text         ${locator_page_newdoc}                      ${page}

    IF                "${type}" == "${EMPTY}"
        Select From List By Value     ${locator_type_newdoc}       0
    ELSE IF           "${type}" == "Manual"
        Select From List By Value     ${locator_type_newdoc}       2
    ELSE IF           "${type}" == "Form"
        Select From List By Value     ${locator_type_newdoc}       7
    END 

    IF                "${depart}" == "${EMPTY}"
        Select From List By Value     ${locator_depart_newdoc}     0
    ELSE IF           "${depart}" == "IT"
        Select From List By Value     ${locator_depart_newdoc}     37
    END 

    IF                "${level}" == "${EMPTY}"
        Select From List By Value     ${locator_level_newdoc}      0
    ELSE IF           "${level}" == "ทั่วไป"
        Select From List By Value     ${locator_level_newdoc}      1
    END 

    IF                "${review}" == "${EMPTY}"
        Select From List By Value     ${locator_review_newdoc}     0
    ELSE IF           "${review}" == "ทุก 6 เดือน"
        Select From List By Value     ${locator_review_newdoc}     1
    ELSE IF           "${review}" == "ปีละ 1 ครั้ง"
        Select From List By Value     ${locator_review_newdoc}     2
    END

    IF                "${time}" == "${EMPTY}"
        Select From List By Value    ${locator_time_newdoc}        0
    ELSE IF           "${time}" == "ตลอดการใช้งาน"
        Select From List By Value    ${locator_time_newdoc}        1
    ELSE IF           "${time}" == "1 เดือน"
        Select From List By Value    ${locator_time_newdoc}        2
    ELSE IF           "${time}" == "3 เดือน"
        Select From List By Value    ${locator_time_newdoc}        3
    ELSE IF           "${time}" == "6 เดือน"
        Select From List By Value    ${locator_time_newdoc}        4
    ELSE IF           "${time}" == "1 ปี"
        Select From List By Value    ${locator_time_newdoc}        5
    END


Save Input New Document
    [Documentation]    ใช้สำหรับคลิกปุ่มบันทึกเอกสารใหม่ กรณียังไม่เลือกผู้ดำเนินการ และตรวจสอบการแจ้งเตือนของระบบ
    Click Element      ${locator_btn_save}
    Wait Until Element Is Visible    ${locator_Alert}
    Check Alert        เพิ่มข้อมูลสำเร็จ!           ${EMPTY}


#ขึ้นทะเบียนเอกสาร / เช็ค Error Border  
Add New Document Error Border  
    [Documentation]    ใช้สำหรับเช็คกรอบแจ้งเตือน ขึ้นทะเบียนเอกสารใหม่
    Open Document 101670066
    Wait Until Element Is Visible                                ${locator_btn_newdoc}
    Click Element      ${locator_btn_newdoc}
    Wait Until Element Is Visible                                ${locator_btn_save}
    [Arguments]        ${nameth}      ${type}    ${depart}       ${page}    ${level}    ${review}    ${chkbox}
    Click Element      ${locator_btn_save}

    IF                "${nameth}" == "${EMPTY}"
        Check Alert Error Border                                 ${locator_nameth_newdoc}
    END 
    IF                "${page}" == "${EMPTY}"
        Check Alert Error Border                                 ${locator_page_newdoc}
    END 

    IF                "${type}" == "${EMPTY}"
           Check Alert Error Border                              ${locator_type_newdoc}
    END
    IF                "${depart}" == "${EMPTY}"    
           Check Alert Error Border                              ${locator_depart_newdoc}
    END 
    IF                "${level}" == "${EMPTY}"
           Check Alert Error Border                              ${locator_level_newdoc}
    END
    IF                "${review}" == "${EMPTY}"
           Check Alert Error Border                              ${locator_review_newdoc}
    END 
    IF                "${chkbox}" == "${EMPTY}"
           Check Alert Error Border                              ${locator_chkbox_newdoc}
    END
    # IF                "${file1}" == "${EMPTY}"
    #        Check Alert Error Border                     ${locator_file1_newdoc}
    # END 
    # IF                "${file2}" == "${EMPTY}"
    #        Check Alert Error Border                     ${locator_file2_newdoc}
    # END
    Close Browser

#ขึ้นทะเบียนเอกสาร / Checkbox เลือกเอกสาร
Select Random Checkboxes
    [Documentation]    รับ Arguments count และทำการสุ่มเลือก chkbox ตามจำนวนที่ระบุ
    [Arguments]             ${count}
    ${checkboxes}=          Split String    ${CHECKBOXES}   ,
    ${checkbox_count}=      Get Length      ${checkboxes}
    Run Keyword If          ${count} > ${checkbox_count}    Fail    Count (${count}) is greater than available checkboxes (${checkbox_count}).
    ${selected_checkbox}=   Evaluate   random.sample(${checkboxes}, int(${count}))    modules=random

    FOR     ${checkbox}     IN              @{selected_checkbox}
            Click Element                   xpath=//label[@for="${checkbox}"]    
    END

Select All Checkboxes
    [Documentation]  เลือก chkbox ทั้งหมดในรายการ
    FOR    ${checkbox}     IN               @{CHECKBOXES}
           Click Element                    xpath=//label[@for="${checkbox}"]
    END

Handle Checkboxes
    [Documentation]  ตรวจสอบ input หากเป็น all จะเลือกทั้งหมด หากเป็นจำนวนจะสุ่มเลือกตามจำนวน 
    [Arguments]      ${input}
    IF    '${input}' == 'all'    
           Select All Checkboxes
    ELSE
           Select Random Checkboxes    ${input}
    END



#ขึ้นทะเบียนเอกสาร / แนบไฟล์

# Select File
#     [Documentation]   ใช้สำหรับแนบไฟล์
#     [Arguments]    ${path_file1}       ${path_file2}
#     Choose File    id=FileUpload1      ${path_file1}
#     Choose File    id=FileUpload2      ${path_file2}



Attach File
    [Documentation]   ใช้สำหรับการอัปโหลดไฟล์และตรวจสอบนามสกุลไฟล์
    [Arguments]     ${file_input_locator}    ${file_path}            ${valid_extension}
    #กำหนดอาร์กิวเมนต์ที่ keyword นี้รับ: ตำแหน่งของอินพุตไฟล์, พาธของไฟล์ และนามสกุลไฟล์ที่ถูกต้อง
    Choose File     ${file_input_locator}    ${file_path}
    #เป็นคำสั่งในการเลือกไฟล์จากพาธที่กำหนด
    ${file_path_in}=        Get Value        ${file_input_locator}
    #ดึงค่าจากอินพุตไฟล์หลังจากที่ได้เลือกไฟล์แล้ว
    ${file_name}=           Get File Name    ${file_path_in}
    #ดึงชื่อไฟล์จากพาธที่ได้มา
    ${file_extension}=      Get File Extension                       ${file_name}
    #ดึงนามสกุลไฟล์จากชื่อไฟล์
    Check File Extension    ${file_extension}                        ${valid_extension}
    #ตรวจสอบว่านามสกุลไฟล์ตรงกับที่กำหนดไว้หรือไม่

Get File Name
    [Documentation]  ใช้สำหรับดึงชื่อไฟล์จากพาธที่รับมา
    [Arguments]      ${file_path}
    ${file_name}=    Split String            ${file_path}            separator=\\
    #Split String ใช้สำหรับแยกชื่อไฟล์ด้วยเครื่องหมาย \\
    [Return]         ${file_name}[-1]
    #คืนค่าส่วนสุดท้ายของอาร์เรย์ที่ได้ ซึ่งก็คือชื่อไฟล์

Get File Extension
    [Documentation]  ใช้สำหรับดึงนามสกุลไฟล์จากชื่อไฟล์
    [Arguments]      ${file_name}
    ${name_parts}=   Split String            ${file_name}            separator=.
    #Split String ใช้สำหรับแยกพาธไฟล์ด้วยเครื่องหมาย .
    [Return]         ${name_parts}[-1]
    #คืนค่าส่วนสุดท้ายของอาร์เรย์ที่ได้ ซึ่งก็คือนามสกุลไฟล์
Check File Extension
    [Documentation]  ใช้สำหรับตรวจสอบว่านามสกุลไฟล์ตรงกับที่กำหนดไว้หรือไม่
    [Arguments]      ${file_extension}                               ${valid_extensions}
    ${lowercase_extension}=    Convert To Lowercase                  ${file_extension}
    #ใช้ Convert To Lowercase เพื่อแปลงนามสกุลไฟล์เป็นตัวพิมพ์เล็กทั้งหมด
    List Should Contain Value                ${valid_extensions}     ${lowercase_extension} 
    #ใช้ List Should Contain Value เพื่อตรวจสอบว่านามสกุลไฟล์ที่แปลงแล้วอยู่ในรายการนามสกุลที่ถูกต้องหรือไม่

Upload File1
    [Documentation]   ใช้สำหรับการแนบไฟล์ลงในอินพุตที่ระบุ กรณีแนบไฟล์ครั้งแรก
    # แนบไฟล์แรก (Word, Excel, Visio, PowerPoint)
    Attach File    ${locator_file1_newdoc}   ${path_file1}           ${VALID_EXTENSIONS_FILE1}
    # แนบไฟล์ที่สอง (PDF)
    Attach File    ${locator_file2_newdoc}   ${path_file2}           ${VALID_EXTENSION_FILE2}

Upload File2
    [Documentation]   ใช้สำหรับการแนบไฟล์ลงในอินพุตที่ระบุ กรณีแนบไฟล์ครั้งที่สอง
    # แนบไฟล์แรก (Word, Excel, Visio, PowerPoint)
    Attach File    ${locator_file1_newdoc}   ${path_file1.1}         ${VALID_EXTENSIONS_FILE1}
    # แนบไฟล์ที่สอง (PDF)
    Attach File    ${locator_file2_newdoc}   ${path_file2.1}         ${VALID_EXTENSION_FILE2}






#ขึ้นทะเบียนเอกสาร / ค้นหา
Search Document
    [Documentation]   ใช้ตรวจสอบการค้นหา และเช็คข้อมูลในตาราง
    Set Selenium Speed    0.2s
    # Open Document 101670066
    # Wait Until Element Is Visible          ${locator_btn_newdoc}
    [Arguments]        ${id}    ${name}    ${type}      ${depart}    ${iso}    ${level}    ${statusdoc}    ${object}    ${statusUse}
    Input Text         ${locator_searchid_newdoc}       ${id}
    Input Text         ${locator_searchname_newdoc}     ${name}
    #ประเภทเอกสาร
    IF                "${type}" == "${EMPTY}"
            Select From List By Value                   ${locator_searchtype_newdoc}         0
    ELSE IF           "${type}" == "Manual"
            Select From List By Value                   ${locator_searchtype_newdoc}         2
    ELSE IF           "${type}" == "Form (แบบฟอร์ม)"
            Select From List By Value                   ${locator_searchtype_newdoc}         7
    END
    #แผนก
    IF                "${depart}" == "IT Software"    
            Select From List By Value                   ${locator_search_Deuser}             37
    ELSE IF           "${depart}" == "${EMPTY}"
            Select From List By Value                   ${locator_search_Deuser}             0
    END
    #เอกสารสอดคล้องกับระบบ
    IF                "${iso}" == "${EMPTY}"    
            Select From List By Value                   ${locator_searchiso_newdoc}          0
    ELSE IF           "${iso}" == "ETAX"
            Select From List By Value                   ${locator_searchiso_newdoc}          8
    ELSE IF           "${iso}" == "ISO9001"  
            Select From List By Value                   ${locator_searchiso_newdoc}          1
    END
    #ระดับชั้นความลับของเอกสาร
    IF                "${level}" == "${EMPTY}"    
            Select From List By Value                   ${locator_searchleve_newdoc}         0
    ELSE IF           "${level}" == "ข้อมูลทั่วไป"
            Select From List By Value                   ${locator_searchleve_newdoc}         1
    ELSE IF           "${level}" == "ข้อมูลลับ"
            Select From List By Value                   ${locator_searchleve_newdoc}         3
    END
    #สถานะเอกสาร
    IF                "${statusdoc}" == "${EMPTY}"    
            Select From List By Value                   ${locator_searchstatus_newdoc}       0
    ELSE IF           "${statusdoc}" == "ปกติ"
            Select From List By Value                   ${locator_searchstatus_newdoc}       2
    ELSE IF           "${statusdoc}" == "ยกเลิก"  
            Select From List By Value                   ${locator_searchstatus_newdoc}       3
    END
    #วัตถุประสงค์
    IF                "${object}" == "${EMPTY}"    
            Select From List By Value                   ${locator_searchobject_newdoc}       0
    ELSE IF           "${object}" == "ขอออกเอกสารใหม่"
            Select From List By Value                   ${locator_searchobject_newdoc}       1
    ELSE IF           "${object}" == "ขอแก้ไขเอกสาร"  
            Select From List By Value                   ${locator_searchobject_newdoc}       4
    ELSE IF           "${object}" == "ขอยกเลิกเอกสาร"    
            Select From List By Value                   ${locator_searchobject_newdoc}       5
    ELSE IF           "${object}" == "ขอทบทวนเอกสาร"
            Select From List By Value                   ${locator_searchobject_newdoc}       3
    ELSE IF           "${object}" == "เอกสารปกติ"  
            Select From List By Value                   ${locator_searchobject_newdoc}       2
    END
    #สถานะผู้ดำเนินงาน
    IF                "${statusUse}" == "${EMPTY}"    
            Select From List By Value                   ${locator_searchobject_newdoc}       0
    ELSE IF           "${statusUse}" == "ยกเลิกเอกสาร"
            Select From List By Value                   ${locator_searchobject_newdoc}       2
    END
    
    
    Click Element                                       ${locator_document_btnsearch}
    # ใช้สำหรับตรวจสอบว่าคอลัมน์ในตารางที่ระบุมีข้อความที่คาดหวัง column ที่ต้องการเช็ค
    Wait Until Element Is Visible                       ${locator_searchtb_newdoc}    
    Table Column Should Contain                         ${locator_searchtb_newdoc}            3         ${id} 

    # Run Keyword And Return Status: คำสั่งนี้ใช้ในการเรียกใช้ Keyword และตรวจสอบสถานะที่ส่งกลับมา (boolean) จากการทำงานของ Keyword ที่กำหนด ในที่นี้คือ Element Should Be Visible.
    # Element Should Be Visible ${table}: เป็น Keyword ที่ตรวจสอบว่า Element ที่ระบุ (ในที่นี้คือ ${locator_table}) มีการแสดงผลอย่างถูกต้องหรือไม่ และคืนค่าเป็น True หาก Element นั้นมองเห็นได้ หรือ False หากไม่เห็นได้.
    ${table_empty} =    Run Keyword And Return Status    Element Should Be Visible    ${locator_table}

    IF                 ${table_empty}
            Table Should Contain                        ${locator_searchtb_newdoc}            - ไม่พบข้อมูล -
    ELSE
            Table Column Should Contain                 ${locator_searchtb_newdoc}            5         ${name}
    END

    Table Column Should Contain                         ${locator_searchtb_newdoc}            6         ${type}
    Table Column Should Contain                         ${locator_searchtb_newdoc}            7         ${depart}
    Table Column Should Contain                         ${locator_searchtb_newdoc}            8         ${object}


Clear Search Document
    [Documentation]    ตรวจสอบการคลิกปุ่มเคลียร์ และเช็คว่าฟีลด์เป็นค่าว่าง
    Click Element                      ${locator_clearbtn_newdoc}
    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าว่าง
    ${locator_search_Id_value}=        Get Value                          ${locator_searchid_newdoc}
    Should Be Empty                    ${locator_search_Id_value}

    ${locator_search_Name_value}=      Get Value                          ${locator_searchname_newdoc}
    Should Be Empty                    ${locator_search_Name_value} 

    #รับค่าเพื่อนำมาเก็บในตัวแปร และตรวจสอบ  locator ว่าเป็นค่าเริ่มต้น
    ${locator_select_status_value}=    Get Selected List Value            ${locator_searchtype_newdoc}
    Should Be Equal                    ${locator_select_status_value}     0

Edit Button New Document
    [Documentation]    ใช้สำหรับคลิกปุ่มแก้ไข หน้าจัดทำเอกสาร
    Wait Until Element Is Visible    ${locator_edittable_doc}
    Click Element                    ${locator_edittable_doc}
    Wait Until Element Is Visible    ${locator_nameth_newdoc}

Edit Document
    [Documentation]    ใช้สำหรับแก้ไขข้อรายละเอียดเอกสาร
    Edit Button New Document
    [Arguments]        ${nameth}      ${type}    ${depart}         ${page}    ${level}    ${review}    ${time}    #${chkbox}    ${file1}    ${file2}             
    Input Text         ${locator_nameth_newdoc}                    ${nameth} 
    Input Text         ${locator_page_newdoc}                      ${page}

    IF                "${type}" == "${EMPTY}"
        Select From List By Value     ${locator_type_newdoc}       0
    ELSE IF           "${type}" == "Manual"
        Select From List By Value     ${locator_type_newdoc}       2
    ELSE IF           "${type}" == "Form"
        Select From List By Value     ${locator_type_newdoc}       7
    END 

    IF                "${depart}" == "${EMPTY}"
        Select From List By Value     ${locator_depart_newdoc}     0
    ELSE IF           "${depart}" == "IT"
        Select From List By Value     ${locator_depart_newdoc}     37
    END 

    IF                "${level}" == "${EMPTY}"
        Select From List By Value     ${locator_level_newdoc}      0
    ELSE IF           "${level}" == "ทั่วไป"
        Select From List By Value     ${locator_level_newdoc}      1
    END 

    IF                "${review}" == "${EMPTY}"
        Select From List By Value     ${locator_review_newdoc}     0
    ELSE IF           "${review}" == "ทุก 6 เดือน"
        Select From List By Value     ${locator_review_newdoc}     1
    ELSE IF           "${review}" == "ปีละ 1 ครั้ง"
        Select From List By Value     ${locator_review_newdoc}     2
    END

    IF                "${time}" == "${EMPTY}"
        Select From List By Value    ${locator_time_newdoc}        0
    ELSE IF           "${time}" == "ตลอดการใช้งาน"
        Select From List By Value    ${locator_time_newdoc}        1
    ELSE IF           "${time}" == "1 เดือน"
        Select From List By Value    ${locator_time_newdoc}        2
    ELSE IF           "${time}" == "3 เดือน"
        Select From List By Value    ${locator_time_newdoc}        3
    ELSE IF           "${time}" == "6 เดือน"
        Select From List By Value    ${locator_time_newdoc}        4
    ELSE IF           "${time}" == "1 ปี"
        Select From List By Value    ${locator_time_newdoc}        5
    END


Select Operation
    [Documentation]    ใช้สำหรับอนุมัติ และเลือกผู้ดำเนินการ หน้ารายละเอียดเอกสาร
    [Arguments]        ${option_text}
    # ${option_text} =    Set Variable    อนุมัติ
    #ใช้ Label แทนการใช้ Value เพราะเลข Value มีการเปลี่ยนทุกครั้ง หาก option ไม่มีการเปลี่ยนค่า ให้ยึดจาก option
    IF                "${option_text}" == "-"
        Select From List By Label        ${locator_edit_Operation}      ----
    ELSE IF           "${option_text}" == "ส่งหัวหน้าแผนกอนุมัติ"
        Select From List By Label        ${locator_edit_Operation}      ส่งหัวหน้าแผนกอนุมัติ
    ELSE IF           "${option_text}" == "อนุมัติ"
        Select From List By Label        ${locator_edit_Operation}      อนุมัติ
    ELSE IF           "${option_text}" == "ไม่อนุมัติ"
        Select From List By Label        ${locator_edit_Operation}      ไม่อนุมัติ
    ELSE IF           "${option_text}" == "ส่ง DCC อนุมัติ"
        Select From List By Label        ${locator_edit_Operation}      ส่ง DCC อนุมัติ
    ELSE IF           "${option_text}" == "ส่งตัวแทนฝ่ายบริหารอนุมัติ"
        Select From List By Label        ${locator_edit_Operation}      ส่งตัวแทนฝ่ายบริหารอนุมัติ
    END 

    Click Button       ${locator_add_Btndepart}
    Wait Until Element Is Visible    ${locator_Alert}
    Check Alert        บันทึกข้อมูลสำเร็จ!    ${EMPTY}  


#อนุมัติเอกสาร Form
Approve Document Form 1
    [Documentation]    ใช้สำหรับอนุมัติเอกสารตามลำดับสิทธิ์ หัวหน้าแผนกอนุมัติ
    Open Document 101610048
    Search Document      ${EMPTY}    โรบอทเอกสาร9    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}       
    Edit Button New Document
    Select Operation     อนุมัติ
    Select Operation     ส่ง DCC อนุมัติ     
    Close Browser

Approve Document Form 2    
    [Documentation]    ใช้สำหรับอนุมัติเอกสารตามลำดับสิทธิ์ DCCอนุมัติ
    Open Document 101610049
    Search Document      ${EMPTY}    โรบอทเอกสาร9    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}       
    Edit Button New Document
    Select Operation     อนุมัติ
    Select Operation     ส่งตัวแทนฝ่ายบริหารอนุมัติ
    Close Browser

Approve Document Form 3
    [Documentation]    ใช้สำหรับอนุมัติเอกสารตามลำดับสิทธิ์ ตัวแทนฝ่ายอนุมัติ
    Open Document 101590718
    Search Document      ${EMPTY}    โรบอทเอกสาร9    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}       
    Edit Button New Document
    Select Operation     อนุมัติ
    Close Browser

#เช็คประวัติการดำเนินงาน
History Document
    [Documentation]    ใช้สำหรับตรวจสอบประวัติการดำเนินงานเอกสาร
    Click Element             ${locator_btn_History}
    Element Should Contain    ${locator_title_History}     ประวัติการดำเนินงาน (เรียงลำดับจากล่าสุด)    
    Click Element             ${locator_close_History}
    
#ลบเอกสาร
Delete Document
    [Documentation]    ใช้สำหรับลบเอกสาร กรณีที่เป็นเอกสารใหม่ ยังไม่ส่งดำเนินการ
    Click Element             ${locator_delete_document}
    Check Alert Cancle 2      ยืนยัน!
    Click Element             ${locator_delete_document}
    Check Alert Ok 2          ยืนยัน!
