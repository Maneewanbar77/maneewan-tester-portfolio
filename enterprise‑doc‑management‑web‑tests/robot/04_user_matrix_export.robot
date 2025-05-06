*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Suite Teardown    Close All Browsers


*** Variables ***
${url}                                  https://test.com/sign-in
${browser}                              chrome

# LOGIN 
${locator_input_email}                  id=email
${locator_input_pass}                   id=password
${locator_btn_Login}                    xpath=/html/body/app-root/layout/empty-layout/div/div/auth-sign-in/div/div[2]/div/form/button
${locator_btn_menu}                     xpath=/html/body/app-root/layout/classy-layout/div/div[1]/button
# User Matrix
${locator_btn_Export}                   xpath=/html/body/app-root/layout/classy-layout/div/div[2]/user-matrix/user-matrix-list/div/div[1]/div[2]/button


*** Keywords ***
Open Test
    [Documentation]    เปิดใช้งานเว็บไซต์ Test
    Set Selenium Speed    0.2s
    Open Browser          ${url}        ${browser}
    Maximize Browser Window

Login Test- Pass
    [Documentation]    ตรวจสอบการเข้าสู่ระบบ
    # ดึง Keyword มาใช้
    Open Test
    # รอจนกว่าในหน้าเพจจะมี Text ที่กำหนดแสดงขึ้นมา
    Wait Until Page Contains                     เข้าสู่แพลตฟอร์ม Test
    Input Text         ${locator_input_email}    Test@gmail.com
    Input Text         ${locator_input_pass}     PasswordTest
    Wait Until Element Is Visible                ${locator_btn_Login}
    Click Button       ${locator_btn_Login}
    Wait Until Element Is Visible                ${locator_btn_menu}   

Open User Matrix And Click Export File
    [Documentation]    เปิดหน้า User Matrix และกด Export
    Login Test - Pass
    Wait Until Page Contains                     ผู้ดูแลระดับบริษัท 
    Execute JavaScript                           document.querySelector('a[href="/company-admin/user-matrix"]').click();
    Wait Until Element Is Visible                ${locator_btn_Export}
    Click Element                                ${locator_btn_Export}   
    Wait For Download To Finish

Wait For Download To Finish
    [Documentation]    รอจนกว่าไฟล์จะดาวน์โหลดเสร็จสิ้น และตรวจสอบชื่อไฟล์ที่ดาวน์โหลด
    # กำหนด path ของไฟล์ .crdownload ซึ่งเป็นไฟล์ที่ถูกสร้างขึ้นระหว่างการดาวน์โหลด
    ${crdownload_file}=    Set Variable    C:\\Users\\maneewan.b\\Downloads\\user-matrix.xlsx.crdownload
    # ตรวจสอบว่าไฟล์ .crdownload ไม่ปรากฏอยู่ ซึ่งหมายถึงการดาวน์โหลดเสร็จสิ้นแล้ว
    Wait Until Keyword Succeeds    2 min    10 sec    File Should Not Exist    ${crdownload_file}
    # เมื่อการดาวน์โหลดเสร็จสิ้น ระบบจะตรวจสอบต่อว่าไฟล์ user-matrix.xlsx มีอยู่ในตำแหน่งที่ระบุ
    Wait Until Keyword Succeeds    1 min    10 sec    File Should Exist    C:\\Users\\maneewan.b\\Downloads\\user-matrix.xlsx


*** Test Cases ***
TC006-1 Export User Matix
    [Documentation]    ตรวจสอบการเปิดหน้า User Matrix และการ Expot File
    Open User Matrix And Click Export File