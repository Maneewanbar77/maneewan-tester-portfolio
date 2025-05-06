*** Settings ***
Library           SeleniumLibrary
Library           Telnet
Suite Teardown    Close All Browsers


*** Variables ***
${url}                                  https://test.com/sign-in
${browser}                              chrome

# LOGIN 
${locator_input_email}                  id=email
${locator_input_pass}                   id=password
${locator_btn_Login}                    xpath=/html/body/app-root/layout/empty-layout/div/div/auth-sign-in/div/div[2]/div/form/button
${locator_btn_menu}                     xpath=/html/body/app-root/layout/classy-layout/div/div[1]/button
# สิทธิ์การเข้าถึง
${locator_roles_create}                 xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer-content/div/div[1]/div[2]/button
# สร้างสิทธิ์การใช้งานใหม่
${locator_create_nameTH}                xpath=//label[mat-label[text()="ชื่อภาษาไทย"]]/following-sibling::input
${locator_create_nameEN}                xpath=//label[mat-label[text()="ชื่อภาษาอังกฤษ"]]/following-sibling::input
${locator_create_description}           xpath=//label[mat-label[text()="คำอธิบาย"]]/following-sibling::input
${locator_create_application}           xpath=//div[contains(@class, 'mat-mdc-select-trigger')]//span[contains(@class, 'mat-mdc-select-placeholder')]
${locator_create_application_option}    xpath=//mat-option//span[normalize-space(text())='APX eTax']
${locator_create_function}              xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[2]/div/form/div/div/div/mat-form-field[3]
${locator_msg_nameTH}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[2]/div/form/div/div/div/div/mat-form-field[1]//mat-error[contains(@class, 'mat-mdc-form-field-error')]
${locator_msg_nameEN}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[2]/div/form/div/div/div/div/mat-form-field[2]//mat-error[contains(@class, 'mat-mdc-form-field-error')]
${locator_msg_description}              xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[2]/div/form/div/div/div/mat-form-field[1]/div[2]/div//mat-error[contains(@class, 'mat-mdc-form-field-error')]
${locator_create_button}                xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[1]/div[2]/button
${locator_dialog_container}             xpath=//mat-dialog-container
# ค้นหาสิทธิ์การใช้งาน
${locator_sorting_button}               xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer-content/div/chip-filter/div/div/mat-chip-listbox/span/button
${locator_search_select}                xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/mat-form-field/div[1]/div[2]/div/mat-select/div/div[1]
${locator_select_nameth}                xpath=/html/body/div[3]/div[4]/div/div/mat-option[1]
${locator_select_nameen}                xpath=/html/body/div[3]/div[4]/div/div/mat-option[2]
${locator_select_description}           xpath=/html/body/div[3]/div[4]/div/div/mat-option[3]
${locator_select_application}           xpath=/html/body/div[3]/div[4]/div/div/mat-option[4]
${locator_search_input}                 xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/mat-form-field/div[1]/div[2]/div/input
${locator_search_input}                 xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/mat-form-field/div[1]/div[2]/div/input
${locator_search_btn}                   xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/button
${locator_table_name}                   xpath=//div[contains(@class, 'roles-grid')]//div[contains(@class, 'truncate')]
${locator_no_data_message}              xpath=//div[contains(@class, 'flex') and contains(@class, 'flex-col')]/div[contains(@class, 'p-8 sm:p-16')]
# ${locator_table_description}            xpath=//div[contains(@class, 'roles-grid')]//div[contains(@class, 'sm:block')]
${locator_table_application}            xpath=//div[contains(@class, 'roles-grid')]//div[contains(@class, 'lg:flex')]
${locator_search_cancle}                xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer-content/div/chip-filter/div/div/mat-chip-listbox/span/mat-chip/span[4]/mat-icon
# แก้ไขสิทธิ์
${locator_edit_btn}                     xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[1]/div[2]/button[2]
${locator_edit_save}                    xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[1]/div[2]/button[2]
# ลบสิทธิ์
${locator_btn_delete}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/roles/roles-list/div/mat-drawer-container/mat-drawer/div/roles-detail/div/div[1]/div[2]/button[1]
${locator_alert_cancle}                 xpath=//*[@id="mat-mdc-dialog-0"]/div/div/confirmation-dialog/div/div[2]/button[1]
${locator_alert_OK}                     xpath=//button[contains(@class, 'mat-warn') and contains(., 'ยืนยัน')]



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

Open Create role input
    [Documentation]    เปิดหน้าสร้างสิทธิ์การเข้าถึง
    Login Test - Pass
    Wait Until Page Contains                     ผู้ดูแลระดับบริษัท 
    Execute JavaScript                           document.querySelector('a[href="/company-admin/roles"]').click();
    Wait Until Element Is Visible                ${locator_roles_create}



# สร้างสิทธิ์การใช้งานใหม่
Create role input
    [Documentation]    เปิดหน้าสร้างสิทธิ์การใช้งาน และตรวจสอบการใส่ข้อมูลสร้างสิทธิ์การใช้งาน
    [Arguments]     ${nameTH}    ${nameEN}     ${description}    ${application}    ${function}
    Open Create role input
    Click Button    ${locator_roles_create}
    Wait Until Page Contains     สิทธิ์การใช้งานใหม่

    Input Text      ${locator_create_nameTH}    ${nameTH}
    Input Text      ${locator_create_nameEN}    ${nameEN} 
    Input Text      ${locator_create_description}                 ${description} 

    Click Element                               ${locator_create_application}
    IF    '${application}' != '${EMPTY}'
           Wait Until Element Is Visible        ${locator_create_application_option}    10s
           Click Element                        ${locator_create_application_option}
    END
    Press Keys    None    ESC

    Click Element    ${locator_create_function}
    IF    '${function}' != '${EMPTY}'
           ${locator_create_function_option}=    Set Variable    xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='${function}']]
           Wait Until Element Is Visible        ${locator_create_function_option}       10s
           Click Element                        ${locator_create_function_option}
    END
    Press Keys    None    ESC

    IF    '${nameTH}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_nameTH}
           ${Text}=    Get Text                 ${locator_msg_nameTH}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุชื่อภาษาไทย
    END

    IF    '${nameEN}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_nameEN}   
           ${Text}=    Get Text                 ${locator_msg_nameEN}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุชื่อภาษาอังกฤษ 
    END
    
    IF    '${description}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_description}  
           ${Text}=    Get Text                 ${locator_msg_description}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุคำอธิบาย 
    END

    IF    '${application}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_application}   
    END

    IF    '${function}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_function} 
    END

Save create role input
    [Documentation]    ใช้สำหรับบันทึกข้อมูลสร้างสิทธิ์การใช้งาน และตรวจสอบข้อความแจ้งเตือนของระบบ
    Click Button                        ${locator_create_button}
    Wait Until Element Is Visible       ${locator_dialog_container}    5s
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}              ทำรายการสำเร็จ
    
Save create role input duplicated
    [Documentation]    ใช้สำหรับบันทึกข้อมูลสร้างสิทธิ์การใช้งาน และตรวจสอบข้อความกรณีมีข้อมูลซ้ำในระบบ
    Click Button                        ${locator_create_button}
    Wait Until Element Is Visible       ${locator_dialog_container}    5s
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}              ชื่อภาษาไทยหรือชื่อภาษาอังกฤษที่ใช้มีอยู่แล้วในระบบ กรุณาลองใหม่อีกครั้งในภายหลัง

Sorting column search
    [Documentation]   ใช้ตรวจสอบการค้นหาข้อมูลสิทธิ์การใช้งาน และเช็คข้อมูลในตารางว่ามีข้อมูลนั้นจริง
    #สร้าง argument เพื่อแทนค่าในการสร้างเงื่อนไข IF
    [Arguments]     ${select}         ${text}     
    Open Create role input
    Click Button    ${locator_sorting_button}
    Click Element   ${locator_search_select}
    #สร้างเงื่อนไข หากข้อความตรงกับอันไหนให้ทำเงื่อนไขนั้น

    IF     '${select}' == "ชื่อภาษาไทย"
            Click Element    ${locator_select_nameth}
            Input Text       ${locator_search_input}    ${text}
            Click Button     ${locator_search_btn}
            ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_name}

              IF    '${status}' == 'FAIL'
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Element Should Contain       ${locator_table_name}         ${text}
              END
    END

    IF     '${select}' == "ชื่อภาษาอังกฤษ"
            Click Element    ${locator_select_nameen}
            Input Text       ${locator_search_input}    ${text}
            Click Button     ${locator_search_btn}
            ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_name}

              IF    '${status}' == 'FAIL'
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Element Should Contain       ${locator_table_name}         ${text}
              END
    END

    IF    '${select}' == "คำอธิบาย"
           Click Element              ${locator_select_description}
           Input Text                 ${locator_search_input}         ${text}
           Click Button               ${locator_search_btn}
           ${locator_table_description}=    Set Variable    xpath=//div[contains(@class, 'roles-grid')]//div[contains(@class, 'sm:block')][contains(text(), '${text}')]
           ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_description}
           
              IF    '${status}' == 'FAIL'

              
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Element Should Contain       ${locator_table_description}         ${text}
              END
           
    END

    IF    '${select}' == "แอปพลิเคชั่น"
           Click Element              ${locator_select_application}
           Click Element              xpath=//*[@id="mat-select-4"]
           Click Element              xpath=//*[@id="mat-option-8"]
           Element Should Contain     ${locator_table_application}    ${text}
    END

Button search Cancle
    [Documentation]   ใช้สำหรับกดปุ่ม cancle ใน Sorting column search
    Click Element     ${locator_search_cancle}



#Edit Roles
Select edit role
    [Documentation]   ใช้สำหรับเลือกข้อมูลกรณีทำการ Sorting column search แล้ว
    Click Element    ${locator_table_name}

Edit role input
    [Documentation]   ใช้สำหรับแก้ไขข้อมูลสิทธิ์การใช้งาน
    Wait Until Element Is Visible               ${locator_edit_btn}

    [Arguments]     ${nameTH}    ${nameEN}      ${description}    
    Input Text      ${locator_create_nameTH}    ${nameTH}
    Input Text      ${locator_create_nameEN}    ${nameEN} 
    Input Text      ${locator_create_description}                           ${description} 
    
    IF    '${nameTH}' == '${EMPTY}'
           Press Keys    ${locator_create_nameTH}                           SPACE
           Press Keys    ${locator_create_nameTH}                           BACKSPACE
           Check Alert Error Border             ${locator_create_nameTH}
           ${Text}=    Get Text                 ${locator_msg_nameTH}
           Should Be Equal As Strings           ${Text}                     กรุณาระบุชื่อภาษาไทย
    END
    
    IF    '${nameEN}' == '${EMPTY}'
           Press Keys    ${locator_create_nameEN}                           SPACE
           Press Keys    ${locator_create_nameEN}                           BACKSPACE 
           Check Alert Error Border             ${locator_create_nameEN}   
           ${Text}=    Get Text                 ${locator_msg_nameEN}
           Should Be Equal As Strings           ${Text}                     กรุณาระบุชื่อภาษาอังกฤษ 
    END
    
    IF    '${description}' == '${EMPTY}'      
           Press Keys    ${locator_create_description}                      SPACE
           Press Keys    ${locator_create_description}                      BACKSPACE
           Check Alert Error Border             ${locator_create_description}  
           ${Text}=    Get Text                 ${locator_msg_description}
           Should Be Equal As Strings           ${Text}                     กรุณาระบุคำอธิบาย 
    END   

Save edit role 
    [Documentation]   ใช้สำหรับกดบันทึกหน้าแก้ไขสิทธิ์การใช้งาน และตรวจสอบแจ้งเตือนของระบบ
    Click Element    ${locator_edit_save}
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}                   ทำรายการสำเร็จ



# Delete Roles
Delete Roles Alert
    [Documentation]   ใช้สำหรับลบข้อมูลหน้าแก้ไขสิทธิ์การใช้งาน และตรวจสอบแจ้งเตือนของระบบ
    Wait Until Element Is Visible       ${locator_btn_delete}
    Click Element                       ${locator_btn_delete}
    Wait Until Element Is Visible       ${locator_dialog_container}    
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}                   ยืนยันการลบข้อมูล

Alert cancle delete roles 
    [Documentation]   ใช้สำหรับกดยกเลิกแจ้งเตือนลบข้อมูลสิทธิ์การใช้งาน
    Click Element                       ${locator_alert_cancle}
    Wait Until Element Is Not Visible   ${locator_alert_cancle}

Alert ok delete roles 
    [Documentation]   ใช้สำหรับกดตกลงแจ้งเตือนลบข้อมูลสิทธิ์การใช้งาน และตรวจสอบแจ้งเตือนของระบบ
    Wait Until Element Is Visible       ${locator_alert_OK}
    Click Button                        ${locator_alert_OK}
    Wait Until Element Is Not Visible   ${locator_alert_OK}
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}                   ทำรายการสำเร็จ


Check Alert Error Border
    [Documentation]   ใช้สำหรับตรวจสอบกรอบแจ้งเตือนสีแดง
    [Arguments]    ${locator_error}
    # ดึงค่า style ของฟิลด์
    ${style}=    Get Element Attribute    ${locator_error}    style
    


*** Test Cases ***
TC003-1 Create role not input - Fail
    [Documentation]    ตรวจสอบการไม่ใส่ข้อมูลสร้างสิทธิ์การใช้งาน ระบบแสดงข้อความแจ้งเตือน
    [Template]    Create role input
    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    [Teardown]    Close Browser
    
TC003-2 Create role input - Pass
    [Documentation]    ตรวจสอบการใส่ข้อมูลสร้างสิทธิ์การใช้งานถูกต้อง ระบบแสดงข้อความแจ้งเตือน
    [Template]    Create role input
    ทดสอบ1    ทดสอบ1    ทดสอบ1    Test    ไฟล์ที่รับเข้าระบบ
    [Teardown]    Run Keywords    Save create role input    AND    Close Browser

TC003-3 Create role input duplication - Fail
    [Documentation]    ตรวจสอบการใส่ข้อมูลสร้างสิทธิ์การใช้งานซ้ำ ระบบแสดงข้อความแจ้งเตือน
    [Template]    Create role input
    ทดสอบ1    ทดสอบ1    ทดสอบ1    Test    ไฟล์ที่รับเข้าระบบ
    [Teardown]    Run Keywords    Save create role input duplicated    AND    Close Browser


TC003-4 Edit role not input - Fail
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลสิทธิ์การใช้งานไม่ใส่ข้อมูล ระบบแสดงข้อความแจ้งเตือน
    Run Keyword        Sorting column search    ชื่อภาษาไทย    ทดสอบ1
    Run Keyword        Select edit role
    Run Keyword        Edit role input          ${EMPTY}    ${EMPTY}    ${EMPTY}    

TC003-5 Edit role input - Pass
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลสิทธิ์การใช้งานถูกต้อง ระบบแสดงข้อความแจ้งเตือน
    [Template]    Edit role input
    ทดสอบ2    ทดสอบ2    ทดสอบ2
    [Teardown]    Run Keywords    Save edit role    AND    Close Browser


TC003-6 Delete role not confirm - Fail
    [Documentation]    ตรวจสอบการลบข้อมูลสิทธิ์การใช้งานไม่ยืนยันลบ ระบบแสดงข้อความแจ้งเตือน 
    Run Keyword        Sorting column search    ชื่อภาษาไทย    ทดสอบ2
    Run Keyword        Select edit role
    Run Keyword        Delete Roles Alert
    Run Keyword        Alert cancle delete roles 

TC003-7 Delete role confirm - Pass
    [Documentation]    ตรวจสอบการลบข้อมูลสิทธิ์การใช้งานกดยืนยันลบ ระบบแสดงข้อความแจ้งเตือน
    Run Keyword        Delete Roles Alert
    Run Keywords        Alert ok delete roles    AND    Close Browser


TC003-9 Search show data role - Fail
    [Documentation]    ตรวจสอบการค้นหาข้อมูลสิทธิ์การใช้งาน กรอกข้อมูลไม่ถูกต้อง ระบบแสดงแจ้งเตือนในตาราง
    [Template]    Sorting column search
    ชื่อภาษาไทย      nnnnx
    ชื่อภาษาอังกฤษ    nnnnx
    คำอธิบาย         nnnnx
    แอปพลิเคชั่น      Test 
    [Teardown]    Run Keywords    Button search Cancle    AND    Close All Browsers

TC003-9 Search show data role - Pass
    [Documentation]    ตรวจสอบการค้นหาข้อมูลสิทธิ์การใช้งาน ระบบแสดงข้อมูลในตาราง
    [Template]    Sorting column search
    ชื่อภาษาไทย      Test 
    ชื่อภาษาอังกฤษ    user
    คำอธิบาย         Test_user 
    แอปพลิเคชั่น      Test
    [Teardown]    Run Keywords    Button search Cancle    AND    Close All Browsers