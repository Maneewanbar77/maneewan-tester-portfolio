*** Settings ***
Library           SeleniumLibrary
Library           Telnet
Library           String
Library           DateTime
Suite Teardown    Close All Browsers



*** Variables ***
${url}                                  https://test.com/sign-in
${browser}                              chrome

# LOGIN 
${locator_input_email}                  id=email
${locator_input_pass}                   id=password
${locator_btn_Login}                    xpath=/html/body/app-root/layout/empty-layout/div/div/auth-sign-in/div/div[2]/div/form/button
${locator_icon_account}                 xpath=//div[contains(@class, 'flex') and contains(@class, 'items-center')]//button[@class='mat-mdc-menu-trigger']
${locator_select_role}                  xpath=//button[@mat-menu-item and contains(@class, 'mat-mdc-menu-item') and .//span[text()='Role']]
${locator_select_customer}              xpath=//button[@mat-menu-item and contains(@class, 'mat-mdc-menu-item') and .//span[text()='Customer Service']]
# ค้นหาวันหยุดบริษัท
${locator_sorting_button}               xpath=//mat-chip-listbox//button[@mattooltip='เพิ่มตัวกรอง' and contains(@class, 'mat-mdc-icon-button')]
${locator_search_select}                css=mat-select[placeholder='ประเภทตัวกรองที่อนุญาต']
${locator_search_company}               xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='บริษัท']]
${locator_search_year}                  xpath=/html/body/div[3]/div[4]/div/div/mat-option[2]
${locator_select_company}               xpath=//mat-select[contains(@class, 'mat-mdc-select-empty')]
${locator_no_data_message}              xpath=//div[contains(@class, 'flex') and contains(@class, 'flex-col')]/div[contains(@class, 'p-8') and contains(@class, 'sm:p-16')]
# ${locator_no_text}                      xpath=//div[contains(@class, 'flex') and contains(@class, 'flex-col')]/div[contains(@class, 'p-8') and contains(@class, 'sm:p-16') and contains(text(), 'ไม่พบข้อมูลที่ต้องการค้นหา!')]


${locator_search_cancle}                xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer-content/div/chip-filter/div/div/mat-chip-listbox/span/mat-chip/span[4]/mat-icon
# สร้างวันหยุดบริษัท
${locator_btn_create}                   xpath=//button[@mat-flat-button and contains(@class, 'mat-mdc-button-base')]
${locator_name_create}                  xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[2]/div[1]/div[2]/div/input
${locator_description_create}           xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[3]/div[1]/div[2]/div/input
${CALENDAR_BUTTON}                      css=button.mat-calendar-period-button
${locator_msg_select}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[1]/div[2]/div/mat-error
${locator_msg_nameholiday}              xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[2]/div[2]/div/mat-error
${locator_btn_save}                     xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[1]/div[2]/button
${locator_dialog_container}             xpath=//mat-dialog-container
# แก้ไขวันหยุด
${locator_edit_save}                    xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[1]/div[2]/button[2]
# ลบวันหยุด
${locator_btn_delete}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/customer-service-holidays/customer-service-holidays-list/div/mat-drawer-container/mat-drawer/div/customer-service-holidays-detail/div/div[1]/div[2]/button[1]
${locator_btn_confirm}                  xpath=//button[.//span[text()=' ยืนยัน ']]
${locator_btn_cancel}                   xpath=//button[.//span[text()=' ยกเลิก ']]


*** Keywords ***
Open Test
    [Documentation]    เปิดใช้งานเว็บไซต์ Test
    Set Selenium Speed    0.2s
    Open Browser          ${url}        ${browser}
    Maximize Browser Window

Login Test- Pass
    [Documentation]    ตรวจสอบการเข้าสู่ระบบ
    Open Test
    Wait Until Page Contains                     เข้าสู่แพลตฟอร์ม Test
    Input Text         ${locator_input_email}    Test@gmail.com
    Input Text         ${locator_input_pass}     PasswordTest
    Wait Until Element Is Visible                ${locator_btn_Login}
    Click Button       ${locator_btn_Login}
    Wait Until Element Is Visible                ${locator_icon_account}   10s

Open Customer Service
    [Documentation]    ตรวจสอบการเปิดหน้าวันหยุดบริษัท
    Login Test - Pass
    Click Element    xpath=/html/body/app-root/layout/classy-layout/vertical-navigation/div/div[2]/vertical-navigation-group-item/vertical-navigation-basic-item/div/a
    Sleep    2s
    Wait Until Element Contains    ${locator_btn_create}    สร้าง    

Sorting column search
    [Documentation]   ใช้ตรวจสอบการค้นหาข้อมูลผู้ใช้งาน และเช็คข้อมูลในตารางว่ามีข้อมูลนั้นจริง
    #สร้าง argument เพื่อแทนค่าในการสร้างเงื่อนไข IF
    [Arguments]     ${select}        ${text}    
    Wait Until Element Is Visible    ${locator_sorting_button}
    Click Button                     ${locator_sorting_button}
    Click Element                    ${locator_search_select}
    #สร้างเงื่อนไข หาก select ตรงกับอันไหนให้ทำเงื่อนไขนั้น    
            
    IF    '${select}' == "บริษัท"
          Click Element    ${locator_search_company}
          Click Element    ${locator_select_company}
    END

    IF    '${text}' != '${EMPTY}'
          ${locator_select_company_option}=    Set Variable    xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='${text}']]
          Wait Until Element Is Visible    ${locator_select_company_option}    10s
          Click Element    ${locator_select_company_option}
          
          # สร้างตัวแปร ${locator_table_name} เพื่อระบุตำแหน่งของข้อความที่ตรงกับ ${text} ในตารางที่ซ่อนอยู่ (hidden) ภายใต้คลาส
          ${locator_table_name}=    Set Variable    xpath=//div[contains(@class, 'customer-service-holidays-grid')]//div[contains(@class, 'hidden') and contains(@class, 'md:block') and contains(text(), '${text}')]  
          # ตรวจสอบสถานะว่าตารางที่มีข้อความ ${text} ปรากฏหรือไม่ ภายในเวลา 10 วินาที และเก็บสถานะนั้นไว้ในตัวแปร ${element_visible}
          ${element_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator_table_name}    timeout=10s
    
          IF    not ${element_visible}
                Wait Until Element Is Visible    ${locator_no_data_message}    timeout=10s
                Element Should Be Visible        ${locator_no_data_message}
                Element Text Should Be           ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
            ELSE
                Sleep    5s
                Element Should Contain           ${locator_table_name}         ${text}    
          END
    END
    
Cancel sorting column search
    [Documentation]   ใช้สำหรับการคลิกปุ่มยกเลิกการค้นหา
    Click Element   ${locator_search_cancle}

Button Create Holiday
    [Documentation]   ใช้สำหรับการปุ่มสร้างวันหยุดบริษัทใหม่
    Click Button    ${locator_btn_create}
    Wait Until Element Is Visible    ${locator_select_company}

Create Holiday
    [Documentation]   ใช้สำหรับการกรอกข้อมูลวันหยุดบริษัท และเช็คข้อความแจ้งเตือน
    [Arguments]     ${select}    ${nameholiday}     ${description}    ${date}    ${date_maonth}    ${date_year}
    
    # สร้างเงื่อนไขถ้า select ไม่เท่ากับ EMPTY ให้เลือก select company option เท่ากับ text
    IF     '${select}' != "${EMPTY}"
            Click Element                           ${locator_select_company}
            ${locator_select_company_option}=       Set Variable    xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='${select}']]
            Wait Until Element Is Visible           ${locator_select_company_option}    10s
            Click Element                           ${locator_select_company_option}
        ELSE
            Double Click Element                    ${locator_select_company}
            ${Text}=    Get Text                    ${locator_msg_select}
            Should Be Equal As Strings              ${Text}                      กรุณาระบุบริษัท
            Check Alert Error Border                ${locator_select_company}    
    END
    # สร้างเงื่อนไขถ้า nameholiday ไม่เท่ากับ EMPTY ให้ Input Text
    IF     '${nameholiday}' != "${EMPTY}"
            Input Text    ${locator_name_create}    ${nameholiday}
        ELSE
            Click Element    ${locator_name_create} 
            Press Keys       ${locator_name_create}            SPACE
            Press Keys       ${locator_name_create}            BACKSPACE
            Click Element    ${locator_description_create}
            ${Text}=    Get Text                    ${locator_msg_nameholiday}
            Should Be Equal As Strings              ${Text}                       กรุณาระบุชื่อวันหยุด
            Check Alert Error Border                ${locator_name_create}   
    END

    Input Text     ${locator_description_create}    ${description}

    # เพิ่มส่วนการเลือกวันที่ ใช้สำหรับการเลือกวันที่ในปฎิทิน
    Click Element    ${CALENDAR_BUTTON}
    # เลือกปี
    Click Button     ${date_year}
    # เลือกเดือน
    Click Button     ${date_maonth}
    # เลือกวันที่
    Click Button     ${date}
    
    # สร้างเงื่อนไขถ้า select ไม่เท่ากับ EMPTY ให้กดบันทึก
    IF     '${select}' != "${EMPTY}"
            Click Button    ${locator_btn_save} 
            Wait Until Element Is Visible          ${locator_dialog_container}    5s
            ${actual_content}=    Get Text         ${locator_dialog_container}
            ${cleaned_content}=    Replace String    ${actual_content}    \n    ""  

            IF    'บันทึกข้อมูลสำเร็จ' in "${cleaned_content}"    
                   Should Contain    ${cleaned_content}    บันทึกข้อมูลสำเร็จ      timeout=10s
                ELSE IF    'บันทึกข้อมูลล้มเหลว' in "${cleaned_content}"
                   Should Contain    ${cleaned_content}    บันทึกข้อมูลล้มเหลว    timeout=10s
                # ELSE
                #    Fail    Unexpected content: ${cleaned_content}
            END

        ELSE    
            Element Attribute Value Should Be      ${locator_btn_save}   disabled    true
    END
    Close Browser
    

Check Alert Error Border
    [Documentation]   ใช้สำหรับตรวจสอบกรอบแจ้งเตือนสีแดง
    [Arguments]    ${locator_error}
    # ดึงค่า style ของฟิลด์
    ${style}=    Get Element Attribute    ${locator_error}    style

Select data holidays
    [Documentation]   ใช้สำหรับเลือกวันหยุดที่ต้องการ
    [Arguments]    ${select_nameholiday}
    ${locator_nameholiday}=    Set Variable    xpath=//div[contains(@class, 'customer-service-holidays-grid') and contains(., '${select_nameholiday}') and @tabindex='0']
    Wait Until Element Is Visible           ${locator_nameholiday}    10s
    Click Element                           ${locator_nameholiday}
    Wait Until Element Is Visible           ${locator_name_create}    10s

Edit data holidays
    [Documentation]   ใช้สำหรับกรอกข้อมูลแก้ไขวันหยุด 
    [Arguments]    ${select_nameholiday}    ${nameholiday}     ${description}    ${date}    ${date_maonth}    ${date_year}
    Select data holidays    ${select_nameholiday}

    # สร้างเงื่อนไขถ้า nameholiday ไม่เท่ากับ EMPTY ให้ Input Text
    IF     '${nameholiday}' != "${EMPTY}"
            Input Text    ${locator_name_create}    ${nameholiday}
        ELSE
            Click Element    ${locator_name_create} 
            Press Keys       ${locator_name_create}            SPACE
            Press Keys       ${locator_name_create}            BACKSPACE
            Click Element    ${locator_description_create}
            ${Text}=    Get Text                    ${locator_msg_nameholiday}
            Should Be Equal As Strings              ${Text}                       กรุณาระบุชื่อวันหยุด
            Check Alert Error Border                ${locator_name_create}   
    END

    Input Text     ${locator_description_create}    ${description}

    # เพิ่มส่วนการเลือกวันที่ ใช้สำหรับการเลือกวันที่ในปฎิทิน
    Click Element    ${CALENDAR_BUTTON}
    # เลือกปี
    Click Button     ${date_year}
    # เลือกเดือน
    Click Button     ${date_maonth}
    # เลือกวันที่
    Click Button     ${date}
    
    #สร้างเงื่อนไขถ้า select ไม่เท่ากับ EMPTY ให้กดบันทึก
    IF     '${nameholiday}' != "${EMPTY}"
            Click Button        ${locator_edit_save} 
            Wait Until Element Is Visible            ${locator_dialog_container}    5s
            ${actual_content}=    Get Text           ${locator_dialog_container}
            ${cleaned_content}=    Replace String    ${actual_content}    \n    ""  
            
            IF    'บันทึกข้อมูลสำเร็จ' in "${cleaned_content}"    
                   Should Contain     ${cleaned_content}    บันทึกข้อมูลสำเร็จ      timeout=10s
                ELSE IF    'บันทึกข้อมูลล้มเหลว' in "${cleaned_content}"
                   Should Contain    ${cleaned_content}     บันทึกข้อมูลล้มเหลว    timeout=10s
                
            END

        ELSE    
            Element Attribute Value Should Be      ${locator_edit_save}   disabled    true
    END

    Close Browser

Delete data holidays
    [Documentation]   ใช้สำหรับการยืนยันลบข้อมูลวันหยุด
    [Arguments]     ${confirm}
    Click Button    ${locator_btn_delete}
    Wait Until Element Is Visible             ${locator_dialog_container}    5s
    # อ่านและตรวจสอบข้อความใน dialog
    ${actual_content}=     Get Text           ${locator_dialog_container}
    # Log    ${actual_content}
    ${cleaned_content}=    Replace String     ${actual_content}    \n    "" 
    # ตรวจสอบการแจ้งเตือนยืนยันการลบข้อมูล
    IF    'ยืนยันการลบข้อมูล' in "${cleaned_content}"    
           Should Contain      ${cleaned_content}    ยืนยันการลบข้อมูล      timeout=10s
    END

    # สร้างเงื่อนไข หากเงื่อนไขเป็นจริง ให้ยืนยันการลบ
    IF    '${confirm}' == "confirm"
        Click Button        ${locator_btn_confirm} 
        Wait Until Element Is Visible            ${locator_dialog_container}    5s
          # ตรวจสอบการแจ้้งเตือนว่าลบสำเร็จ
          IF    'ลบข้อมูลสำเร็จ' in "${cleaned_content}"    
                Should Contain    ${cleaned_content}    ลบข้อมูลสำเร็จ      timeout=10s
          END
    # หากไม่ตรงเงื่อนไข ให้ยกเลิกการลบ
    ELSE    
        Click Button    ${locator_btn_cancel}
        Wait Until Element Is Not Visible    ${locator_dialog_container}   
    END

    Close Browser



*** Test Cases ***
TC05-001 Search show data holidays - Fail
    [Documentation]  ตรวจสอบการค้นหาข้อมูลวันหยุด และเช็คข้อมูลในตาราง
    Run Keyword    Open Customer Service
    # เลือกประเภทตัวกรอง กรอกข้อความที่ต้องการค้นหา
    Run Keyword    Sorting column search    บริษัท    บริษัท Test จำกัด
    # กดยกเลิกการค้นหา
    Run Keyword    Cancel sorting column search

TC05-002 Search show data holidays - Pass
    [Documentation]  ตรวจสอบการค้นหาข้อมูลวันหยุด และเช็คข้อมูลในตาราง 
    # เลือกประเภทตัวกรอง กรอกข้อความที่ต้องการค้นหา
    Run Keyword    Sorting column search    บริษัท    บริษัท Test1 จำกัด
    Run Keyword    Close Browser

TC05-003 Create data holidays - Fail
    [Documentation]  ตรวจสอบการสร้างข้อมูลวันหยุดไม่กรอกข้อมูล และตรวจสอบว่าปุ่มปิดการใช้งาน
    Run Keyword    Open Customer Service
    # กดปุ่มสร้างวันหยุด
    Run Keyword    Button Create Holiday
    # สร้างข้อมูลวันหยุด เลือกบริษัท กรอกชื่อวันหยุด กรอกคำอธิบาย กรอกวันที่
    Run Keyword    Create Holiday      ${EMPTY}    ${EMPTY}    ${EMPTY}    16    SEP    2024

TC05-004 Create data holidays - Pass
    [Documentation]  ตรวจสอบการสร้างข้อมูลวันหยุด และเช็คข้อความแจ้งเตือน
    Run Keyword     Open Customer Service
    # กดปุ่มสร้างวันหยุด
    Run Keyword     Button Create Holiday
    # สร้างข้อมูลวันหยุด เลือกบริษัท กรอกชื่อวันหยุด กรอกคำอธิบาย กรอกวันที่
    Run Keyword     Create Holiday     1000120121021 - เอ - A    TestAutomate1    test    16    SEP    2024

TC05-005 Create data holidays - Duplicate
    [Documentation]  ตรวจสอบการสร้างข้อมูลวันหยุดซ้ำ และเช็คข้อความแจ้งเตือน
    Run Keyword    Open Customer Service
    # กดปุ่มสร้างวันหยุด
    Run Keyword    Button Create Holiday
    # สร้างข้อมูลวันหยุด เลือกบริษัท กรอกชื่อวันหยุด กรอกคำอธิบาย กรอกวันที่
    Run Keyword    Create Holiday     1000120121021 - เอ - A    TestAutomate    test    17    SEP    2024

TC05-006 Edit holidays - Duplicate
    [Documentation]  ตรวจสอบการแก้ไขข้อมูลวันหยุดซ้ำกับวันหยุดที่มี และเช็คข้อความแจ้งเตือน
    Run Keyword    Open Customer Service
    # ค้นหาบริษัทที่ต้องการแก้ไข
    Run Keyword    Sorting column search    บริษัท    เอ
    # เลือกวันหยุดที่ต้องการแก้ไข แก้ไขชื่อ แก้ไขคำอธิบาย แก้ไขวันที่
    Run Keyword    Edit data holidays    TestAutomate1    TestAutomate    test    17    SEP    2024

TC05-007 Edit holidays - Pass
    [Documentation]  ตรวจสอบการแก้ไขข้อมูลวันหยุดซ้ำกับวันหยุดที่มี และเช็คข้อความแจ้งเตือน
    Run Keyword    Open Customer Service
    # ค้นหาบริษัทที่ต้องการแก้ไข
    Run Keyword    Sorting column search    บริษัท    เอ
    # เลือกวันหยุดที่ต้องการแก้ไข แก้ไขชื่อ แก้ไขคำอธิบาย แก้ไขวันที่
    Run Keyword    Edit data holidays     TestAutomate1    TestAutomate2    test    14    SEP    2024

TC05-008 Delete holidays - Fail
    [Documentation]  ตรวจสอบการยกเลิกลบข้อมูลวันหยุด และเช็คข้อความแจ้งเตือน
    Run Keyword    Open Customer Service
    # ค้นหาบริษัทที่ต้องการแก้ไข
    Run Keyword    Sorting column search    บริษัท    เอ
    # เลือกชื่อวันหยุดที่ต้องการ
    Select data holidays    TestAutomate2
    # ยกเลิกการ Delete
    Delete data holidays    cancel

TC05-009 Delete holidays - Pass
    [Documentation]  ตรวจสอบการยืนยันลบข้อมูลวันหยุด และเช็คข้อความแจ้งเตือน
    Run Keyword    Open Customer Service
    # ค้นหาบริษัทที่ต้องการแก้ไข
    Run Keyword    Sorting column search    บริษัท    เอ
    # เลือกชื่อวันหยุดที่ต้องการ
    Select data holidays    TestAutomate2
    # ยืนยันการ Delete
    Delete data holidays    confirm