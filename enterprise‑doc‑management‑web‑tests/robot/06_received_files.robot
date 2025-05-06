*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           Collections
Suite Teardown    Close All Browsers


*** Variables ***
${url}                                  https://test.com/sign-in
${browser}                              chrome

# LOGIN 
${locator_input_email}                  id=email
${locator_input_pass}                   id=password
${locator_btn_Login}                    xpath=/html/body/app-root/layout/empty-layout/div/div/auth-sign-in/div/div[2]/div/form/button
${locator_btn_menu}                     xpath=/html/body/app-root/layout/classy-layout/div/div[1]/button
# Received File
${locator_btn_Export}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/user-matrix/user-matrix-list/div/div[1]/div[2]/button
${locator_menu_receive}                 xpath=//vertical-navigation-basic-item//a[contains(@class, 'vertical-navigation-item') and .//span[contains(text(), 'Received Files')]]
${locator_btn_filter}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/apx-etax-received-file-list/div/chip-filter/div/div/mat-chip-listbox/span/button/span[4]
${locator_select_filter}                xpath=//mat-select[@placeholder='ประเภทตัวกรองที่อนุญาต']
# ชื่อไฟล์
${locator_select_name}                  xpath=//mat-option[contains(., 'ชื่อไฟล์')]
${locator_select_status}                xpath=//mat-option[contains(., 'สถานะ')]
${locator_dropdown_status}              css=.mat-mdc-select.mat-mdc-select-empty
# วันที่รับข้อมูล    
${locator_select_date}                  xpath=//mat-option[contains(., 'วันที่รับข้อมูลจาก')]
${locator_select_month}                 xpath=//button[@aria-label='Choose month and year']
# ช่องกรอกข้อมูล
${locator_input_filter}                 xpath=//mat-form-field[contains(@class, 'mat-mdc-form-field')]//input[@type='text']
${locator_filter_status}                xpath=
${locator_btn_search}                   xpath=//button[.//span[normalize-space(text())='เพิ่ม']]
${locator_no_data_message}              xpath=//div[contains(@class, 'flex') and contains(@class, 'flex-col')]/div[contains(@class, 'p-8 sm:p-16')]


*** Keywords ***
Open Test
    [Documentation]    เปิดใช้งานเว็บไซต์ Test
    # ตั้งค่าความเร็วของ Selenium อยู่ที่ 0.2s
    Set Selenium Speed    0.2s
    Open Browser          ${url}      ${browser}
    # เปิดหน้าต่าง Browser ให้เป็นจอใหญ่
    Maximize Browser Window

Login Test - Pass
    [Documentation]    ตรวจสอบการเข้าสู่ระบบ
    # ดึง Keyword มาใช้
    Open Test
    # รอจนกว่าในหน้าเพจจะมี Text ที่กำหนดแสดงขึ้นมา
    Wait Until Page Contains                     เข้าสู่แพลตฟอร์ม Test
    Input Text         ${locator_input_email}    Test@gmail.com
    Input Text         ${locator_input_pass}     PasswordTest
    # รอจนกว่า Element ที่กำหนดจะปรากฎ
    Wait Until Element Is Visible                ${locator_btn_Login}
    Click Button       ${locator_btn_Login}
    # รอจนกว่า Element ที่กำหนดจะปรากฎ
    Wait Until Element Is Visible                ${locator_btn_menu}   

Open Menu Received File
    [Documentation]    ตรวจสอบการคลิกเมนูไฟล์ที่รับเข้าระบบ
    # ดึง Keyword มาใช้
    Open Test
    # ดึง Keyword มาใช้
    Login Test - Pass
    # รอจนกว่า Element ที่กำหนดจะปรากฎ
    Wait Until Element Is Visible    ${locator_menu_receive}
    Click Element    ${locator_menu_receive}
    # รอจนกว่าในหน้าเพจจะมี Text ที่กำหนดแสดงขึ้นมา
    Wait Until Page Contains    สถานะ

Search Receive File input
    [Documentation]    ตรวจสอบการเลืิกประเภทตัวกรอง และตรวจสอบข้อมูลที่แสดงในตาราง
    # สร้าง Arguments เพื่อแทนค่าที่จะใส่
    [Arguments]    ${filter}    ${text}

    Click Element    ${locator_btn_filter}
    Click Element    ${locator_select_filter}

    # สร้างเงื่อนไข หาก ${filter} = Text ที่กำหนด ให้ทำ IF หากไม่ตรงให้ตรวจสอบ ELSE IF 
    IF    '${filter}' == "ชื่อไฟล์"
        Click Element    ${locator_select_name}
        Input Text       ${locator_input_filter}    ${text}
        Click Button     ${locator_btn_search}
        # ดึง Keyword มาใช้
        Verify Data In Table    ${text}
    ELSE IF    '${filter}' == "สถานะ"
        Click Element    ${locator_select_status}
        Click Element    ${locator_dropdown_status} 
        # ดึง Keyword มาใช้
        Select Status    ${text}
    ELSE IF    '${filter}' == "วันที่รัับข้อมูลจาก"
        Click Element    ${locator_select_date}
    END

Verify Data In Table
    [Documentation]    ใช้สำหรับตรวจสอบข้อมูลในตารางกรณีเลือกชื่อไฟล์ และตรวจสอบแจ้งเตือนกรณีที่ไม่พบข้อมูล
    [Arguments]    ${text}
    ${is_text_present}=    Run Keyword And Return Status    Element Should Contain    xpath=//div[contains(@class, 'inline-grid')]/div[1]/span    ${text}
    Run Keyword If    ${is_text_present}    Log    "Text found: ${text}"
    Run Keyword If    not ${is_text_present}    Element Should Contain    xpath=//div[contains(@class, 'text-center') and contains(text(), 'Data not found')]    Data not found

Select Status
    [Documentation]    ใช้สำหรับการเลือกข้อมูลใน dropdown สถานะ จากนั้นตรวจสอบข้อมูลหรือแจ้งเตือนในตาราง
    [Arguments]    ${text}

    ${locator_txt_status}=    Set Variable    xpath=//mat-option[span[text()=' ${text} ']]

    # ตรวจสอบค่าของ ${text} เพื่อเลือกตัวเลือกที่ตรงกัน
    IF    '${text}' == 'รับไฟล์'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    ELSE IF    '${text}' == 'สร้างงานแล้ว'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    ELSE IF    '${text}' == 'ไฟล์ซ้ำ'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    ELSE IF    '${text}' == 'ยกเลิกไฟล์'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    ELSE IF    '${text}' == 'พบข้อผิดพลาด'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    END

    ${locator_table_contain}=    Set Variable    xpath=//div[contains(@class, 'text-center') and contains(text(), '${text}')]
    # ตรวจสอบว่ามีข้อมูลที่ตรงกับคำที่ต้องการหรือไม่
    ${is_text_present}=    Run Keyword And Return Status    Element Should Contain    ${locator_table_contain}    ${text}

    # ถ้าไม่พบข้อมูลที่ต้องการ ให้ตรวจสอบข้อความ "Data not found" แทน
    IF    '${text}' != '${text}'
        Element Should Contain    xpath=//div[contains(@class, 'text-center') and contains(text(), 'Data not found')]    Data not found
    END
    
    
    
Select Date
    [Documentation]    ใช้สำหรับการเลือกวันที่ ในการกดประเภทตัวกรอง และตรวจสอบข้อมูลที่เลือกในตาราง
    [Arguments]    ${date}    ${date_month}    ${date_year}
    # ไว้สำหรับคลิกปุ่มเพื่อเลือก วันเดือนปี
    Click Element    ${locator_select_month}
    # เลือกปี
    Click Button     ${date_year}
    # เลือกเดือน
    Click Button     ${date_month}
    # เลือกวันที่
    Wait Until Page Contains    ${date}
    Click Button     ${date}
    # สร้างรูปแบบวันที่ที่คาดหวัง
    ${Expected_date}=    Set Variable     ${date_year}-${date_month}-${date}
    # รอจนกว่า locator จะขึ้นมา
    Wait Until Element Is Visible         ${locator_btn_filter} 
    # กำหนด dictionary สำหรับแปลงเดือนเป็นตัวเลข เพื่อนำมาตรวจสอบ
    ${month_map}=    Create Dictionary    JAN=01    FEB=02    MAR=03    APR=04    MAY=05    JUN=06    JUL=07    AUG=08    SEP=09    OCT=10    NOV=11    DEC=12
    # แปลงเดือนเป็นหมายเลข
    ${month_number}=    Get From Dictionary    ${month_map}    ${date_month}
    # สร้างรูปแบบวันที่ที่คาดหวัง
    ${Expected_date}=    Set Variable        ${date_year}-${month_number}-${date}



Verify Table Contain
    [Documentation]    ตรวจสอบข้อมูลที่เลือกในตาราง
    [Arguments]    ${texts}
    ${locator_table_contain}=    Set Variable    xpath=//div[contains(@class, 'text-center') and contains(text(), '${texts}')]
    # ตรวจสอบว่ามีข้อมูลที่ตรงกับคำที่ต้องการหรือไม่
    ${is_text_present}=    Run Keyword And Return Status    Element Should Contain    ${locator_table_contain}    ${texts}

    # ถ้าไม่พบข้อมูลที่ต้องการ ให้ตรวจสอบข้อความ "Data not found" แทน
    IF    not ${is_text_present}
        Element Should Contain    xpath=//div[contains(@class, 'text-center') and contains(text(), 'Data not found')]    Data not found
    END
    


*** Test Cases ***
TC09-001 Search Receive File input - Fail
    Open Menu Received File
    Search Receive File input    ชื่อไฟล์    ----x.csv
    Close Browser

TC09-002 Search Receive File input - Pass
    Open Menu Received File
    Search Receive File input    สถานะ    สร้างงานแล้ว
    Search Receive File input    วันที่รัับข้อมูลจาก    ${EMPTY}
    Select Date    11    JUN    2024