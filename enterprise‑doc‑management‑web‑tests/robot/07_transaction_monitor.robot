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
# Transaction
${locator_menu_transaction}             xpath=//vertical-navigation-basic-item//a[contains(@class, 'vertical-navigation-item') and .//span[contains(text(), 'Transactions')]]
${locator_btn_filter}                   xpath=//button[@mattooltip='เพิ่มตัวกรอง']
${locator_select_filter}                xpath=//mat-select[@placeholder='ประเภทตัวกรองที่อนุญาต']

# ชื่อไฟล์
${locator_select_name}                  xpath=//mat-option[contains(., 'ชื่อไฟล์')]
${locator_select_status}                xpath=//mat-option[contains(., 'สถานะ')]
${locator_dropdown_status}              css=.mat-mdc-select.mat-mdc-select-empty
# วันที่รับข้อมูล    
${locator_select_date}                  xpath=//mat-option[contains(., 'วันที่สร้างงานจาก')]
${locator_select_month}                 xpath=//button[@aria-label='Choose month and year']
${locator_select_number}                xpath=//mat-option[contains(., 'เลขที่สัญญา')]
${locator_btn_search}                   xpath=//button[.//span[normalize-space(text())='เพิ่ม']]
${locator_input_filter}                 xpath=//mat-form-field[contains(@class, 'mat-mdc-form-field')]//input[@type='text']
# เลือกชื่องาน Transaction
${locator_select_transaction}           id=row-0




*** Keywords ***
Open Test
    [Documentation]    เปิดใช้งานเว็บไซต์ Test
    Set Selenium Speed    0.2s
    Open Browser          ${url}      ${browser}
    Maximize Browser Window


Login Test - Pass
    [Documentation]    ตรวจสอบการเข้าสู่ระบบ
    Open Test
    Wait Until Page Contains                     เข้าสู่แพลตฟอร์ม Test
    Input Text         ${locator_input_email}    Test@gmail.com
    Input Text         ${locator_input_pass}     PasswordTest
    Wait Until Element Is Visible                ${locator_btn_Login}
    Click Button       ${locator_btn_Login}
    Wait Until Element Is Visible                ${locator_btn_menu}   

Open Menu Transaction
    [Documentation]    ตรวจสอบการคลิกเมนูทรานแซคชัน
    Open Test
    Login Test - Pass
    Wait Until Element Is Visible    ${locator_menu_transaction}
    Click Element                    ${locator_menu_transaction}
    Wait Until Page Contains         ทรานแซคชัน

Search Transaction 
    [Documentation]    ตรวจสอบการเลืิกประเภทตัวกรอง และตรวจสอบข้อมูลที่แสดงในตาราง
    [Arguments]    ${filter}    ${text}

    Wait Until Element Is Visible    ${locator_btn_filter}
    Click Button                     ${locator_btn_filter}
    Click Element                    ${locator_select_filter}
  
    IF    '${filter}' == "ชื่องาน"
        Click Element    xpath=//mat-option[contains(., 'ชื่องาน')]
        Input Text       ${locator_input_filter}    ${text}
        Click Button     ${locator_btn_search} 
        Verify Data In Table    ${text}
    ELSE IF    '${filter}' == "สถานะ"
        Click Element    ${locator_select_status}  
        Click Element    ${locator_dropdown_status} 
        Select Status    ${text}
    ELSE IF    '${filter}' == "วันที่รัับข้อมูลจาก"
        Click Element    ${locator_select_date}
    END

# Verify Data In Table
#     [Documentation]    ใช้สำหรับตรวจสอบข้อมูลในตารางกรณีเลือกชื่อไฟล์ และตรวจสอบแจ้งเตือนกรณีที่ไม่พบข้อมูล
#     [Arguments]    ${text}
#     ${is_text_present}=    Run Keyword And Return Status    Element Should Contain    xpath=//div[contains(@class, 'inline-grid')]/div[1]/span    ${text}
#     Run Keyword If    ${is_text_present}    Log    "Text found: ${text}"
#     Run Keyword If    not ${is_text_present}    Element Should Contain    xpath=//div[contains(@class, 'text-center') and contains(text(), 'Data not found')]    Data not found

Verify Data In Table
    [Documentation]    ใช้สำหรับตรวจสอบข้อมูลในตารางกรณีเลือกชื่อไฟล์ และตรวจสอบแจ้งเตือนกรณีที่ไม่พบข้อมูล
    [Arguments]    ${text}
    # ตรวจสอบว่าข้อความ Data not found เป็น True หรือ False
     ${data_not_found}=    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    xpath=//div[contains(text(), 'Data not found')]    timeout=5s

    IF    ${data_not_found}    
          Element Should Contain           xpath=//div[contains(@class, 'text-center') and contains(text(), 'Data not found')]    Data not found    
    ELSE    
          Wait Until Element Is Visible    xpath=//span[contains(@class, 'mat-mdc-tooltip-trigger') and contains(text(), '${text}')]    timeout=10s 
          Element Should Be Visible        xpath=//span[contains(@class, 'mat-mdc-tooltip-trigger') and contains(text(), '${text}')]
    END
 
Select Status
    [Documentation]    ใช้สำหรับการเลือกข้อมูลใน dropdown สถานะ จากนั้นตรวจสอบข้อมูลหรือแจ้งเตือนในตาราง
    [Arguments]    ${text}

    ${locator_txt_status}=    Set Variable    xpath=//mat-option[span[text()=' ${text} ']]

    # ตรวจสอบค่าของ ${text} เพื่อเลือกตัวเลือกที่ตรงกัน
    IF    '${text}' == 'กำลังทำงาน'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    ELSE IF    '${text}' == 'สำเร็จ'
        Click Element    ${locator_txt_status}
        # Verify Table Contain    ${text}
    ELSE IF    '${text}' == 'เกิดข้อผิดพลาด'
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

Select transaction
    [Documentation]    ใช้สำหรับการเลือกข้อมูลในตาราง
    Click Element    ${locator_select_transaction}
    Wait Until Page Contains    รายละเอียด

Verify transaction page detail
    [Documentation]    ใช้สำหรับตรวจสอบข้อมูลหน้ารายละเอียด
    [Arguments]    ${sectiontxt}    ${text}
    # ดึงค่าจากหน้าเว็บ ใช้ Get Text เพื่อดึงค่าจาก <div class="text-secondary">
    ${actual_value}=    Get Text    xpath=//div[contains(@class, 'min-w-40') and contains(normalize-space(), '${sectiontxt}')]/following-sibling::div[contains(@class, 'text-secondary')]
    # Log เพื่อตรวจสอบค่าใน Log เช่น Value for 'วันที่สร้างงาน': 2024-11-11 14:18:46
    Log    "Value for '${sectiontxt}': ${actual_value}"
    # ตรวจสอบว่าค่าที่ได้ตรงกับค่าที่คาดหวัง
    Should Be Equal As Strings    ${actual_value}    ${text}    
    # Log ยืนยันว่าผ่าน
    Log    "Field '${sectiontxt}' has value '${actual_value}', as expected."
                              


*** Test Cases ***
TC12-001 Search transaction input - Fail
    [Documentation]    ตรวจสอบการค้นหาชื่องานไม่ถูกต้อง
    Open Menu Transaction
    Search Transaction    ชื่องาน     xxx
    Close Browser

TC12-002 Search transaction input - Pass
    [Documentation]    ตรวจสอบการค้นหาชื่องานและสถานะถูกต้อง
    Open Menu Transaction
    Search Transaction    ชื่องาน    eDoc_HPTROS03_20241102_New_12
    Search Transaction    สถานะ    สำเร็จ

TC12-003 Select transaction should be display detail - Pass
    [Documentation]    ตรวจสอบการเลือกชื่องานและตรวจสอบรายละเอียดที่แสดง
    Select transaction
    Verify transaction page detail    วันที่สร้างงาน    2024-11-11 14:18:46 
    Verify transaction page detail    ชื่องาน         eDoc_HPTROS03_20241102_New_12
    Verify transaction page detail    เลขที่สัญญา     1067000160
    Verify transaction page detail    วันที่สร้างทรานเซคชั่น    2024-11-11 14:30:00
    Verify transaction page detail    สถานะ         Success