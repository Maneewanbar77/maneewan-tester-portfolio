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
${locator_user_create}                  xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer-content/div/div[1]/div[2]/button
# ค้นหาสิทธิ์การใช้งาน
${locator_sorting_button}               xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer-content/div/chip-filter/div/div/mat-chip-listbox/span/button                               
${locator_search_select}                xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/mat-form-field/div[1]/div[2]/div/mat-select/div/div[1]
${locator_select_name}                  xpath=/html/body/div[3]/div[4]/div/div/mat-option[1]
${locator_select_surname}               xpath=/html/body/div[3]/div[4]/div/div/mat-option[2]
${locator_select_email}                 xpath=/html/body/div[3]/div[4]/div/div/mat-option[3]
${locator_select_phone}                 xpath=/html/body/div[3]/div[4]/div/div/mat-option[4]
${locator_search_input}                 xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/mat-form-field/div[1]/div[2]/div/input
${locator_search_btn}                   xpath=/html/body/div[3]/div[2]/div/div/div[2]/div/button
${locator_table_name}                   xpath=//div[contains(@class, 'company-admin-users-grid')]//div[contains(@class, 'truncate')]
${locator_no_data_message}              xpath=//div[contains(@class, 'flex') and contains(@class, 'flex-col')]/div[contains(@class, 'p-8 sm:p-16')]
${locator_search_cancle}                xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer-content/div/chip-filter/div/div/mat-chip-listbox/span/mat-chip/span[4]/mat-icon
# สร้างผู้ใช้งานใหม่
${locator_create_button}                xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[1]/div[2]/button
${locator_create_name}                  xpath=//label[mat-label[text()="ชื่อ"]]/following-sibling::input
${locator_create_surname}               xpath=//label[mat-label[text()="นามสกุล"]]/following-sibling::input
${locator_create_email}                 xpath=//input[@formcontrolname='email']
${locator_create_phone}                 xpath=//label[mat-label[text()="โทรศัพท์"]]/following-sibling::input
${locator_create_status}                xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[4]/div[1]/div[2]/div/mat-select/div
${locator_create_role}                  xpath=//div[contains(@class, 'mat-mdc-select-trigger')]//span[contains(@class, 'mat-mdc-select-placeholder')]
${locator_msg_name}                     xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[2]/div/form/div/div[2]/div/div/mat-form-field[1]/div[2]/div/mat-error
${locator_msg_surname}                  xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[2]/div/form/div/div[2]/div/div/mat-form-field[2]/div[2]/div/mat-error
${locator_msg_email}                    xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[1]/div[2]/div/mat-error
${locator_msg_phone}                    xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[2]/div/form/div/div[2]/div/mat-form-field[2]/div[2]/div/mat-error
${locator_dialog_container}             xpath=//mat-dialog-container
# แก้ไขผู้ใช้งาน
${locator_select_table}                 xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer-content/div/div[2]/div[1]/div/div[2]/div/div/div
${locator_edit_save}                    xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[1]/div[2]/button[2]
# ลบผู้ใช้งาน
${locator_btn_delete}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/users/users-list/div/mat-drawer-container/mat-drawer/div/users-detail/div/div[1]/div[2]/button[1]
${locator_alert_OK}                     xpath=/html/body/div[3]/div[2]/div/mat-dialog-container/div/div/confirmation-dialog/div/div[2]/button[2]
${locator_alert_cancle}                 xpath=/html/body/div[3]/div[2]/div/mat-dialog-container/div/div/confirmation-dialog/div/div[2]/button[1]

*** Keywords ***
Open Test
    [Documentation]    เปิดใช้งานเว็บไซต์ Test
    Set Selenium Speed    0.2s
    Open Browser          ${url}        ${browser}
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

Open User
    [Documentation]    เปิดหน้าผู้ใช้งาน
    Login Test - Pass
    Wait Until Page Contains                     ผู้ดูแลระดับบริษัท 
    Execute JavaScript                           document.querySelector('a[href="/company-admin/users"]').click();
    Wait Until Element Is Visible                ${locator_user_create}

Open User Input
    [Documentation]    เปิดหน้าสร้างข้อมูลผู้ใช้งานใหม่
    Open User
    Click Button                 ${locator_user_create}
    Wait Until Page Contains     ผู้ใช้งานใหม่

Sorting column search
    [Documentation]   ใช้ตรวจสอบการค้นหาข้อมูลผู้ใช้งาน และเช็คข้อมูลในตารางว่ามีข้อมูลนั้นจริง
    #สร้าง argument เพื่อแทนค่าในการสร้างเงื่อนไข IF
    [Arguments]     ${select}    ${text}    ${status1} 
    Open User
    Click Button    ${locator_sorting_button}
    Click Element   ${locator_search_select}
    #สร้างเงื่อนไข หากข้อความตรงกับอันไหนให้ทำเงื่อนไขนั้น
    ${locator_table_status}=    Set Variable    xpath=//div[contains(@class, 'company-admin-users-grid')]//div[contains(@class, 'lg:block')][contains(text(), '${status1}')]

    IF     '${select}' == "ชื่อ"
            Click Element    ${locator_select_name}
            Input Text       ${locator_search_input}    ${text}
            Click Button     ${locator_search_btn}
            ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_name}
            
              IF    '${status}' == 'FAIL'
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Wait Until Page Contains     ${text}
                     Element Should Contain       ${locator_table_name}         ${text}
                     Element Should Contain       ${locator_table_status}       ${status1}
              END
    END

    IF     '${select}' == "นามสกุล"
            Click Element                        ${locator_select_surname}
            Input Text                           ${locator_search_input}    ${text}
            Click Button                         ${locator_search_btn}
            ${locator_table_surname}=    Set Variable    xpath=//div[contains(@class, 'company-admin-users-grid')]//div[contains(@class, 'truncate')][contains(text(), '${text}')]
            ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_surname}

              IF    '${status}' == 'FAIL'
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Element Should Contain       ${locator_table_surname}      ${text}
                     Element Should Contain       ${locator_table_status}       ${status1}
              END
    END

    IF    '${select}' == "email"
           Click Element                          ${locator_select_email}
           Input Text                             ${locator_search_input}       ${text}
           Click Button                           ${locator_search_btn}
           ${locator_table_email}=    Set Variable    xpath=//div[contains(@class, 'company-admin-users-grid')]//div[contains(@class, 'sm:block')][contains(text(), '${text}')]
           ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_email}
           
              IF     '${status}' == 'FAIL'
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Element Should Contain       ${locator_table_email}        ${text}
                     Element Should Contain       ${locator_table_status}       ${status1}
              END  
    END

    IF    '${select}' == "phone"
           Click Element                          ${locator_select_phone}
           Input Text                             ${locator_search_input}       ${text}
           Click Button                           ${locator_search_btn} 
           ${locator_table_phone}=    Set Variable    xpath=//div[contains(@class, 'company-admin-users-grid')]//div[contains(@class, 'lg:flex')][contains(text(), '${text}')]
           ${status}        ${value}=    Run Keyword And Ignore Error    Element Should Be Visible    ${locator_table_phone}
           
              IF     '${status}' == 'FAIL'
                     Element Should Be Visible    ${locator_no_data_message}
                     Element Text Should Be       ${locator_no_data_message}    ไม่พบข้อมูลที่ต้องการค้นหา!
              ELSE
                     Element Should Contain       ${locator_table_phone}        ${text}
                     Element Should Contain       ${locator_table_status}       ${status1}
              END  
    END

Button search Cancle
    [Documentation]   ใช้สำหรับกดปุ่ม cancle ใน Sorting column search
    Click Element     ${locator_search_cancle}

Create user input
    [Documentation]    ตรวจสอบการใส่ข้อมูลสร้างผู้ใช้งานใหม่
    [Arguments]     ${name}    ${surname}        ${email}    ${phone}    ${role}    ${status}
    Input Text      ${locator_create_name}       ${name}
    Input Text      ${locator_create_surname}    ${surname} 
    Input Text      ${locator_create_email}      ${email}
    Input Text      ${locator_create_phone}      ${phone} 

    Click Element                                ${locator_create_role}
    IF    '${role}' != '${EMPTY}'
           ${locator_create_role_option}=    Set Variable    xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='${role}']]
           Wait Until Element Is Visible        ${locator_create_role_option}    10s
           Click Element                        ${locator_create_role_option}
    END
    Press Keys    None    ESC

    Click Element    ${locator_create_status}
    IF    '${status}' != '${EMPTY}'
           ${locator_create_function_option}=    Set Variable    xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='${status}']]
           Wait Until Element Is Visible        ${locator_create_function_option}   10s
           Click Element                        ${locator_create_function_option}
    END
    Press Keys    None    ESC

    IF    '${name}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_name}
           ${Text}=    Get Text                 ${locator_msg_name}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุชื่อ
    END

    IF    '${surname}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_surname}   
           ${Text}=    Get Text                 ${locator_msg_surname}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุนามสกุล
    END
    
    IF    '${email}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_email}  
           ${Text}=    Get Text                 ${locator_msg_email}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุอีเมล
    END

    IF    '${phone}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_phone}  
           ${Text}=    Get Text                 ${locator_msg_phone}
           Should Be Equal As Strings           ${Text}                        กรุณาหมายเลขโทรศัพท์มือถือ
    END

    IF    '${role}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_role}   
    END

    IF    '${status}' == '${EMPTY}'
           Check Alert Error Border             ${locator_create_status} 
    END

Check Alert Error Border
    [Documentation]   ใช้สำหรับตรวจสอบกรอบแจ้งเตือนสีแดง
    [Arguments]    ${locator_error}
    # ดึงค่า style ของฟิลด์
    ${style}=    Get Element Attribute    ${locator_error}    style

Save create user input
    [Documentation]    ใช้สำหรับบันทึกข้อมูลสร้างผู้ใช้งาน และตรวจสอบข้อความแจ้งเตือนของระบบ
    Click Button                        ${locator_create_button}
    Wait Until Element Is Visible       ${locator_dialog_container}    5s
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}              ทำรายการสำเร็จ

Save create user input duplicate
    [Documentation]    ใช้สำหรับบันทึกข้อมูลสร้างผู้ใช้งานซ้ำ และตรวจสอบข้อความแจ้งเตือนของระบบ
    Click Button                        ${locator_create_button}
    Wait Until Element Is Visible       ${locator_dialog_container}    5s
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}              อีเมลของคุณถูกใช้งานแล้ว กรุณาเปลี่ยนอีเมลและลองใหม่อีกครั้งในภายหลัง

#Edit User
Select edit user
    [Documentation]   ใช้สำหรับเลือกข้อมูลกรณีทำการ Sorting column search แล้ว
    Click Element                        ${locator_select_table}
    Wait Until Element Is Visible        ${locator_edit_save}

Edit user input
    [Documentation]   ใช้สำหรับแก้ไขข้อมูลผู้ใช้งาน
    [Arguments]     ${name}    ${surname}        ${phone}    ${status}
    Input Text      ${locator_create_name}       ${name}
    Input Text      ${locator_create_surname}    ${surname} 
    Input Text      ${locator_create_phone}      ${phone} 

    IF    '${name}' == '${EMPTY}'
           Press Keys    ${locator_create_name}                                SPACE
           Press Keys    ${locator_create_name}                                BACKSPACE
           Check Alert Error Border             ${locator_create_name}
           ${Text}=    Get Text                 ${locator_msg_name}
           Should Be Equal As Strings           ${Text}                        กรุณาระบุชื่อ
    END

    IF    '${surname}' == '${EMPTY}'
           Press Keys    ${locator_create_surname}                              SPACE
           Press Keys    ${locator_create_surname}                              BACKSPACE
           Check Alert Error Border             ${locator_create_surname}   
           ${Text}=    Get Text                 ${locator_msg_surname}
           Should Be Equal As Strings           ${Text}                         กรุณาระบุนามสกุล
    END

    IF    '${phone}' == '${EMPTY}'
           Press Keys    ${locator_create_phone}                                SPACE
           Press Keys    ${locator_create_phone}                                BACKSPACE
           Check Alert Error Border             ${locator_create_phone}  
           ${Text}=    Get Text                 ${locator_msg_phone}
           Should Be Equal As Strings           ${Text}                         กรุณาหมายเลขโทรศัพท์มือถือ
    END
    
    Click Element    ${locator_create_status}
    IF    '${status}' != '${EMPTY}'
           ${locator_create_function_option}=    Set Variable    xpath=//mat-option[.//span[contains(@class, 'mdc-list-item__primary-text') and normalize-space(text())='${status}']]
           Wait Until Element Is Visible        ${locator_create_function_option}   10s
           Click Element                        ${locator_create_function_option}
    END
    Press Keys    None    ESC   
    
Save edit user input   
    [Documentation]   ใช้สำหรับบันทึกข้อมูลหน้าแก้ไขผู้ใช้งาน และตรวจสอบแจ้งเตือนของระบบ
    Click Element    ${locator_edit_save}
    Wait Until Element Is Visible       ${locator_dialog_container}         5s
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}                   ทำรายการสำเร็จ

# Delete User
Delete User Alert
    [Documentation]   ใช้สำหรับลบข้อมูลหน้าแก้ไขผู้ใช้งาน และตรวจสอบแจ้งเตือนของระบบ
    Wait Until Element Is Visible       ${locator_btn_delete}
    Click Element                       ${locator_btn_delete}
    Wait Until Element Is Visible       ${locator_dialog_container}    
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}                   ยืนยันการลบข้อมูล

Alert cancle delete user
    [Documentation]   ใช้สำหรับกดยกเลิกแจ้งเตือนลบข้อมูลผู้ใช้งาน
    Click Element                       ${locator_alert_cancle}
    Wait Until Element Is Not Visible   ${locator_alert_cancle}

Alert ok delete user 
    [Documentation]   ใช้สำหรับกดตกลงแจ้งเตือนลบข้อมูลผู้ใช้งาน และตรวจสอบแจ้งเตือนของระบบ
    Wait Until Element Is Visible       ${locator_alert_OK}
    Click Button                        ${locator_alert_OK}
    Wait Until Element Is Not Visible   ${locator_alert_OK}
    ${actual_content}=    Get Text      ${locator_dialog_container}
    Should Contain                      ${actual_content}                   ทำรายการสำเร็จ



*** Test Cases ***
TC004-1 Search show data role - Fail
    [Documentation]    ตรวจสอบการค้นหาข้อมูล user กรอกข้อมูลไม่ถูกต้อง ระบบแสดงแจ้งเตือนในตาราง
    [Template]    Sorting column search
    ชื่อ        xxxx    ${EMPTY}
    นามสกุล    xxxx    ${EMPTY}
    email     xxxx    ${EMPTY}
    phone     xxxx    ${EMPTY}
    [Teardown]    Run Keywords    Button search Cancle    AND    Close All Browsers

TC004-2 Search show data role - Pass
    [Documentation]    ตรวจสอบการค้นหาข้อมูล user กรอกข้อมูลถูกต้อง ระบบแสดงแจ้งเตือนในตาราง
    [Template]    Sorting column search
    ชื่อ        QA            ใช้งาน
    นามสกุล    Test          ใช้งาน
    email     maneewan.b@gamil.com    ใช้งาน
    phone     0933333333    ใช้งาน
    [Teardown]    Run Keywords    Button search Cancle    AND    Close All Browsers

TC004-3 Create user not input - Fail
    [Documentation]    ตรวจสอบการสร้างข้อมูล user กรอกข้อมูลไม่ถูกต้อง ระบบแสดงแจ้งเตือนในตาราง
    Run Keyword    Open User Input
    Run Keyword    Create user input    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Run Keyword    Close All Browsers
    

TC004-4 Create user input - Pass
    [Documentation]    ตรวจสอบการสร้างข้อมูล user กรอกข้อมูลถูกต้อง ระบบแสดงแจ้งเตือนในตาราง
    Run Keyword     Open User Input
    Run Keyword     Create user input       User    Test    1998.qatest1@gmail.com    0851234567    ผู้ดูแลระดับบริษัท    ยังไม่เปิดการใช้งาน
    Run Keywords    Save create user input      Close All Browsers

TC004-5 Create user duplicate - Fail
    [Documentation]    ตรวจสอบการสร้างข้อมูล user กรอกข้อมูลซ้ำ ระบบแสดงแจ้งเตือนในตาราง
    Run Keyword     Open User Input
    Run Keyword     Create user input       Admin    Company    Test@gmail.com    0888888888    ผู้ดูแลระดับบริษัท    ปกติ
    Run Keywords    Save create user input duplicate    AND    Close All Browsers


    
TC004-6 Edit user data duplicate - Fail
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลผู้ใช้งานไม่ถูกต้อง ระบบสามารถบันทึกได้
    Run Keyword     Sorting column search    email    1998.qatest1@gmail.com    ยังไม่เปิดใช้งาน
    Run Keyword     Select edit user
    Run Keyword     Edit user input          QA    Test    0933333333    ปกติ 
    Run Keywords    Save edit user input  AND    Close All Browsers


TC004-7 Edit user input data - Pass
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลผู้ใช้งานถูกต้อง ระบบแสดงแจ้งเตือน
    Run Keyword     Sorting column search    email    1998.qatest1@gmail.com    ใช้งาน
    Run Keyword     Select edit user
    Run Keyword     Edit user input          UserTest    UserTest    0933333333    ปกติ
    Run Keywords    Save edit user input  AND    Close All Browsers



TC004-8 Delete user not confirm - Fail
    [Documentation]    ตรวจสอบการลบข้อมูล user ไม่ยืนยันลบ ระบบแสดงข้อความแจ้งเตือน 
    Run Keyword     Sorting column search    email    1998.qatest1@gmail.com    ใช้งาน
    Run Keyword     Select edit user
    Run Keywords    Delete User Alert    AND    Alert cancle delete user

TC004-9 Delete user confirm - Pass
    [Documentation]    ตรวจสอบการลบข้อมูล user ยืนยันลบ ระบบแสดงข้อความแจ้งเตือน 
    Run Keywords    Delete User Alert    AND    Alert ok delete user
    Run Keyword     Close All Browsers