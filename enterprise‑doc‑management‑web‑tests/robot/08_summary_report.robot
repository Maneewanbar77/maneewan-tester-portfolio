*** Settings ***
Library           SeleniumLibrary
# Library           OperatingSystem
Library           Collections
# Library           BuiltIn
Library           DateTime
Library           String
Suite Teardown    Close All Browsers


*** Variables ***
${url}                                  https://test.com/sign-in
${browser}                              chrome

# LOGIN 
${locator_input_email}                  id=email
${locator_input_pass}                   id=password
${locator_btn_Login}                    xpath=/html/body/app-root/layout/empty-layout/div/div/auth-sign-in/div/div[2]/div/form/button
${locator_btn_menu}                     xpath=/html/body/app-root/layout/classy-layout/div/div[1]/button
# Summary
${locator_menu_summary}                 xpath=//a[contains(@class, 'vertical-navigation-item')]//span[contains(text(), 'Summary Generated And Sent Document')]
${locator_start_month}                  xpath=//div[contains(@class, 'mdc-evolution-chip__action')]//span[contains(@class, 'mdc-evolution-chip__text-label') and contains(., 'Received Date From')]
${locator_end_month}                    xpath=//div[contains(@class, 'mdc-evolution-chip__action')]//span[contains(@class, 'mdc-evolution-chip__text-label') and contains(., 'Received Date To')]
${locator_select_month_year}            xpath=//button[@aria-label="Choose month and year"]


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
    Input Text         ${locator_input_email}    Test@gamil.com
    Input Text         ${locator_input_pass}     PasswordTest
    Wait Until Element Is Visible                ${locator_btn_Login}
    Click Button       ${locator_btn_Login}
    Wait Until Element Is Visible                ${locator_btn_menu}   

Open Menu Summary
    [Documentation]    ตรวจสอบการคลิกเมนู Summary
    Open Test
    Login Test - Pass
    Scroll Element Into View         ${locator_menu_summary}
    Wait Until Element Is Visible    ${locator_menu_summary}
    Click Element                    ${locator_menu_summary}
    Wait Until Page Contains         รายงาน

Select date
    [Documentation]    ใช้สำหรับคลิกเลือกวันที่เริ่มและวันที่จบ พร้อมตรวจสอบการเลือกวันที่ว่าตรงกับที่ป้อนจริง
    [Arguments]    ${receivedate}    ${date}    ${date_month}    ${date_year}    ${txt}
    # สร้างเงื่อนไข หาก ${receivedate} เข้ากับเงื่อนไข from ให้ทำ หากไม่เข้าเงื่อนไขให้ทำ else
    IF    '${receivedate}' == 'from'
        Click Element    ${locator_start_month}
    ELSE
        Click Element    ${locator_end_month}
    END
    
    # คลิก เพื่อเลือกปี และเดือน
    Click Element    ${locator_select_month_year}
    # เลือกปี และเลือกเดือน
    Click Button     ${date_year}
    Click Button     ${date_month}
    # รอให้วันที่แสดงก่อนคลิก
    Wait Until Page Contains    ${date}
    Click Button     ${date}
    
    # สร้างรูปแบบวันที่ที่คาดหวัง
    ${Expected_date}=    Set Variable           ${date_year}-${date_month}-${date}
    # กำหนด dictionary สำหรับแปลงเดือนเป็นตัวเลข เพื่อนำมาตรวจสอบ
    ${month_map}=        Create Dictionary      JAN=01    FEB=02    MAR=03    APR=04    MAY=05    JUN=06    JUL=07    AUG=08    SEP=09    OCT=10    NOV=11    DEC=12
    # แปลงเดือนเป็นหมายเลข
    ${month_number}=     Get From Dictionary    ${month_map}    ${date_month}
    # เติมเลข 0 ด้านหน้าให้เป็น 2 หลัก 
    ${date_padded}=      Evaluate         str(${date}).zfill(2)

    # สร้าง Expected Date ในรูปแบบ YYYY-MM-DD
    ${Expected_date}=    Set Variable     ${date_year}-${month_number}-${date_padded}

    Log    Expected Date: ${Expected_date}  # ตรวจสอบค่าที่ได้
          
    # สร้างเงื่อนไข หาก txt = from ให้ตรวจสอบ Received Date From หากไม่เข้าเงื่อนไข ให้ตรวจสอบ Received Date To
    IF    '${txt}' == 'from'
        # ตรวจสอบ Received Date From ว่าตรงกับวันที่ที่ถูกป้อนเข้าไป
        Element Should Contain         xpath=//div[contains(@class, 'mdc-evolution-chip__action')]    Received Date From    ${Expected_date}
    ELSE 
        # รอให้แสดงจากนั้นตรวจสอบ Received Date To ว่าตรงกับวันที่ที่ถูกป้อนเข้าไป
        Wait Until Element Contains    xpath=//mat-chip[contains(., 'Received Date To') and contains(., '${Expected_date}')]    ${Expected_date}
        Element Should Contain         xpath=//mat-chip[contains(., 'Received Date To') and contains(., '${Expected_date}')]    ${Expected_date}
    END
    
    Wait Until Page Contains    ${Expected_date}

    
# Verify data in table
#     [Documentation]    ใช้สำหรับตรวจสอบข้อมูลในตาราง
#     [Arguments]    ${from_date}    ${end_date}
    
#     ${current_date}=         Get Time        %Y-%m-%d
#     ${start_date_obj}=       Convert Date    ${from_date}       %Y-%m-%d
#     ${end_date_obj}=         Convert Date    ${end_date}        %Y-%m-%d
#     ${current_date_obj}=     Convert Date    ${current_date}    format=%Y-%m-%d   
#     Should Be True    ${start_date_obj} <= ${current_date_obj} <= ${end_date_obj}


xxx
    [Arguments]    ${date}    ${date_month}    ${date_year} 
    # สร้างรูปแบบวันที่ที่คาดหวัง
    ${Expected_date}=    Set Variable           ${date_year}-${date_month}-${date}
    # กำหนด dictionary สำหรับแปลงเดือนเป็นตัวเลข เพื่อนำมาตรวจสอบ
    ${month_map}=        Create Dictionary      JAN=01    FEB=02    MAR=03    APR=04    MAY=05    JUN=06    JUL=07    AUG=08    SEP=09    OCT=10    NOV=11    DEC=12
    # แปลงเดือนเป็นหมายเลข
    ${month_number}=     Get From Dictionary    ${month_map}    ${date_month}
    # เติมเลข 0 ด้านหน้าให้เป็น 2 หลัก 
    ${date_padded}=      Evaluate         str(${date}).zfill(2)

    # สร้าง Expected Date ในรูปแบบ YYYY-MM-DD
    ${Expected_date}=    Set Variable     ${date_year}-${month_number}-${date_padded}
    ${START_DATE}=       Set Variable
    ${END_DATE}=         Set Variable
    

Verify
    [Arguments]    ${START_DATE}    ${END_DATE}
    # ${dates}=    Get WebElements    xpath=//div[contains(@class, 'mat-mdc-tooltip-trigger')]
    # FOR    ${date}    IN    @{dates}
    #        ${date_text}=    Get Text    ${date}
    #        Run Keyword If    '${date_text}' >= '${START_DATE}' AND '${date_text}' <= '${END_DATE}'    Log    Found date: ${date_text}
    # END

    # ${DATE_COLUMN_XPATH}=    Set Variable   //div[contains(@class, 'inline-grid')]/div[1]/span
    #  # รอให้ตารางโหลดเสร็จ
    # Wait Until Element Is Visible    ${DATE_COLUMN_XPATH}
    # # ตรวจสอบแต่ละวันที่ในช่วงที่กำหนด 
    # @{valid_dates}=    Split String    ${DATE_RANGE}    
    # ${found_count}=    Set Variable    ${0}

    # FOR    ${valid_date}    IN    @{valid_dates}
    #     ${present}=    Run Keyword And Return Status    
    #     ...    Page Should Contain Element    ${DATE_COLUMN_XPATH}[text()=" ${valid_date} "]
        
    #     Run Keyword If    ${present}    
    #     ...    Run Keywords
    #     ...    Log    พบวันที่ ${valid_date} ในตาราง    AND
    #     ...    Set Variable    ${found_count + 1}    found_count
    # END
    # # แสดงผลการตรวจสอบ
    # Log    พบวันที่ในช่วงที่กำหนดทั้งหมด ${found_count} วัน
  

    # ดึงข้อมูลวันที่ทั้งหมดจากตาราง
    ${date_elements}=    Get WebElements    //div[contains(@class, 'inline-grid')]/div[1]/span
    
    # แสดงค่าที่จะใช้ตรวจสอบ
    Log    ตรวจสอบวันที่ในช่วง ${START_DATE} ถึง ${END_DATE}
    
    # สร้างตัวแปรนับจำนวนวันที่อยู่ในช่วง
    ${date_count_in_range}=    Set Variable    ${0}
    @{dates_in_range}=    Create List
    
    # ตรวจสอบแต่ละวันที่
    FOR    ${element}    IN    @{date_elements}
        ${date_text}=    Get Text    ${element}
        ${date_text}=    Strip String    ${date_text}
        
        # ตรวจสอบว่าเป็นวันที่ที่มีรูปแบบถูกต้อง
        ${is_valid_date}=    Run Keyword And Return Status    
        ...    Evaluate    re.match(r'\\d{4}-\\d{2}-\\d{2}', '${date_text}')    modules=re
        
        # ถ้าเป็นวันที่ ให้ตรวจสอบว่าอยู่ในช่วงหรือไม่
        # ${is_in_range}=    Set Variable    ${FALSE}

        Run Keyword If    ${is_valid_date} == False    Continue For Loop
        # IF    ${is_valid_date}    
        ${target_date}=     Convert Date     ${date_text}    date_format=%Y-%m-%d    
        ${start_date}=    Convert Date    ${START_DATE}    date_format=%Y-%m-%d    
        ${end_date}=    Convert Date    ${END_DATE}    date_format=%Y-%m-%d    
        ${is_in_range}=    Evaluate    $target_date >= $start_date and $target_date <= $end_date
    

        # ถ้าวันที่อยู่ในช่วง ให้เพิ่มในรายการและเพิ่มตัวนับ
        Run Keyword If    ${is_in_range}    
        ...    Run Keywords
        ...    Append To List    ${dates_in_range}    ${date_text}    AND
        ...    Set Test Variable    ${date_count_in_range}    ${date_count_in_range + 1}
    END 
    
    
    # แสดงผลการตรวจสอบ
    Log    พบวันที่ในช่วง ${START_DATE} ถึง ${END_DATE} จำนวน ${date_count_in_range} วัน
    Log    วันที่ที่พบ: ${dates_in_range}
    
    # ตรวจสอบว่าพบวันที่ในช่วงที่กำหนดอย่างน้อย 1 วัน
    Should Be True    ${date_count_in_range} > 0    ไม่พบวันที่ใดๆ ในช่วงที่กำหนด: ${START_DATE} ถึง ${END_DATE}
    
    
    
    
Verify data error in table
    Element Should Contain    xpath=//div[contains(@class, 'text-center') and contains(text(), 'Data not found')]    Data not found
    
    

    


*** Test Cases ***
TC21-003 Search condition date is correct, The system should be display detail report
    [Documentation]    ตรวจสอบการเลือกวันที่ และตรวจสอบข้อมูลที่แสดง
    Open Menu Summary
    Select date    from    4    NOV    2024    from
    Select date    end     11    NOV    2024    end
    Verify    2024-11-04    2024-11-11
    # Verify data in table    2024-11-04    2024-11-11