***Settings***
Library    SeleniumLibrary
# Suite Setup    Open CSP Masterlis
Resource    ${CURDIR}/00_variables.robot
Resource    ${CURDIR}/05_keywords_common.robot
Resource    ${CURDIR}/06_keywords_department.robot
Suite Teardown    Close All Browsers

***Test Cases***
## แผนก
TC002-1 Verify Add Department - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-แผนก และตรวจสอบว่าระบบมีการแจ้งเตือน
    Run Keyword        Verify Add Department - Pass    Robot            ทดสอบเอกสาร 
    Run Keyword        Check Alert                     เพิ่มข้อมูลสำเร็จ!    ${EMPTY}
    Run Keyword        Close All Browsers

TC002-2 Verify Add Department - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-แผนก ไม่ถูกต้อง ระบบแสดงแจ้งเตือน
    [Template]         Verify Add Department - Fail
    ${EMPTY}           ${EMPTY}    
    QA0                ${EMPTY}
    ${EMPTY}           ทดสอบ   
    [Teardown]         Close All Browsers

TC002-3 Verify Search Department - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูล เพิ่ม-แผนก การค้นหาข้อมูลแผนก และปุ่มเคลียร์
    Run Keyword        Verify Search Filters Department - Pass    Robot    ทดสอบเอกสาร    ปกติ  
    Run Keyword        Verify clear Filters Department - Pass
    Run Keyword        Close All Browsers


TC002-4 Verify Edit Department - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขแผนก    ระบบแสดงแจ้งเตือน
    Run Keyword        Verify Search Filters Department - Pass    Robot    ทดสอบเอกสาร     ปกติ   
    Run Keyword        Verify Edit Department - Pass              ทดสอบเอกสาร1
    Run Keyword        Verify Search Filters Department - Pass    Robot    ทดสอบเอกสาร1    ปกติ
    Run Keyword        Close All Browsers

TC002-5 Verify Delete Department - Pass
    [Tags]    Done
    [Documentation]    ใช้สำหรับตรวจสอบการลบข้อมูลแผนก ระบบแสดงแจ้งเตือน เลือกยกเลิก-ตกลง
    Run Keyword        Verify Search Filters Department - Pass    Robot    ทดสอบเอกสาร1    ปกติ 
    Run Keyword        Verify Delete Department - Pass
    Run Keyword        Close All Browsers


# #สิทธิ์การใช้งาน
TC002-6 Verify System Add License - Pass
    [Tags]    
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-สิทธิ์การใช้งาน - Pass
    Run Keyword        Verify System Add License - Pass        Test3    เทส1    robot    User    ปกติ
    Run Keyword        Verify Search Filters License - Pass    Test3    เทส1    User
    Run Keyword        Verify clear Filters License - Pass    
    Run Keyword        Close Browser

TC002-7 Verify System Add License - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-สิทธิ์การใช้งาน - Fail
    [Template]         Verify System Add License - Fail
    USR    ผู้ใช้งาน    User    User    ปกติ
    [Teardown]         Close Browser

TC002-8 Verify Edit license - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูล สิทธิ์การใช้งาน - Pass
    Run Keyword    Open License
    Run Keyword    Verify Search Filters License - Pass    Test3     เทส1    User
    Run Keyword    Verify Edit license - Pass              Test16    เทส2     robot    User    ปกติ
    Run Keyword    Verify Search Filters License - Pass    Test16    เทส2    User    
    Run Keyword    Close Browser

TC002-9 Verify Edit license - Fail
    [Tags]   Done 
    [Documentation]    ตรวจสอบการแก้ไขข้อมูล สิทธิ์การใช้งาน - Fail รอแก้ไข bug
    Run Keyword     Verify Edit license - Pass    USR    ผู้ใช้งาน    User    User    ปกติ
    Run Keywords    Verify Edit license - Fail    AND    Close Browser


TC002-10 Verify Function license - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการเลือกฟังก์ชัน และเช็คฟังก์ชันที่ใช้งานจากการเลือก - สิทธิ์การใช้งาน
    Run Keyword    Open License
    Run Keyword    Verify Search Filters License - Pass    Test16    เทส2    User 
    Run Keyword    Verify Function license - Add           ประเภทเอกสาร
    Run Keyword    Close Browser

TC002-11 Verify Function license Delete - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการเลือกฟังก์ชัน และเช็คฟังก์ชันที่ใช้งานจากการเลือก - สิทธิ์การใช้งาน
    Run Keyword    Open License
    Run Keyword    Verify Search Filters License - Pass    Test16    เทส2    User 
    Run Keyword    Verify Function license - Delete        ประเภทเอกสาร
    Run Keyword    Close Browser

TC002-12 Verify Delete license - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการลบข้อมูล สิทธิ์การใช้งาน - Pass
    Run Keyword     Open License
    Run Keyword     Verify Search Filters License - Pass    Test16    เทส2    User
    Run Keywords    Verify Delete license - Pass    AND    Close Browser

## ตั้งค่าระบบ / ผู้ใช้งาน
TC002-13 Verify Search Filters User - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูลผู้ใช้งาน ผลลัพน์แสดงในตาราง และคลิกปุ่มเคลียร์
    [Template]         Verify Search Filters User - Pass
    101670066    มณีวรรณ    IT Software    ปกติ
    [Teardown]         Run Keywords    Verify clear Filters User - Pass    AND    Close Browser

TC002-14 Verify Edit User - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลผู้ใช้งานไม่ถูกต้อง - Fail
    [Template]         Verify Edit User
    ${EMPTY}      ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    [Teardown]         Close Browser

TC002-15 Verify Edit User - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลผู้ใช้งานถูกต้อง - Pass
    [Template]         Verify Edit User
    จันทร์วาณิชย์   CSP    ผู้ใช้งาน    IT Software    มณีวรรณ    บารมี
    [Teardown]         Run Keywords      Check Alert    บันทึกข้อมูลสำเร็จ!   ${EMPTY}      AND    Close Browser

TC002-16 Add License User - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการเพิ่มข้อมูลผู้ใช้ สิทธิ์การใช้งาน - Fail
    [Template]         Add License User 
    ${EMPTY}    ${EMPTY}    ${EMPTY}
    [Teardown]         Run Keyword    Close Browser
TC002-17 Add License User - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการเพิ่มข้อมูลผู้ใช้ สิทธิ์การใช้งานถูกต้อง - Pass
    [Template]         Add License User 
    จันทร์วาณิชย์    Card Perso    ผู้ใช้งาน
    [Teardown]         Run Keywords    Check Alert    เพิ่มข้อมูลสำเร็จ!    ${EMPTY}   AND    Close Browser

TC002-18 Edit Add License User - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบข้อมูลผู้ใช้ แก้ไขสิทธิ์การใช้งาน - Fail
    [Template]         Edit Add License User
    ${EMPTY}    ${EMPTY}    ${EMPTY}
    [Teardown]         Close Browser

TC002-19 Edit Add License User - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบข้อมูลผู้ใช้ แก้ไขสิทธิ์การใช้งานถูกต้อง - Pass
    [Template]         Edit Add License User
    จันทร์วาณิชย์    Card Perso    หัวหน้าแผนก
    [Teardown]         Run Keywords      Check Alert    บันทึกข้อมูลสำเร็จ!   ${EMPTY}    AND    Close Browser

TC002-20 Clear Edit Add License User - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบข้อมูลผู้ใช้ แก้ไขสิทธิ์การใช้งาน คลิกปุ่มเคลียร์ - Pass
    Clear Edit Add License User

## ตั้งค่าระบบ / ผู้ใช้งาน / ระดับชั้นความลับเอกสาร 

TC002-21 Delete Add License User
    [Tags]    Done
    [Documentation]    ตรวจสอบข้อมูลผู้ใช้ แก้ไขสิทธิ์การใช้งาน คลิกปุ่มเคลียร์ - Pass
    Delete Add License User

TC002-22 Level Document User Add
    [Tags]    Done
    [Documentation]    ตรวจสอบระดับความลับเอกสาร เลือกเพิ่มระดับเอกสาร และเช็คระดับเอกสารที่มีสิทธิ์
    [Template]         level document
    ข้อมูลทั่วไป
    [Teardown]         Close Browser

TC002-23 Level Document User Delete
    [Tags]    Done
    [Documentation]    ตรวจสอบระดับความลับเอกสาร เลือกลบระดับเอกสารที่มีสิทธิ์ และเช็คระดับเอกสาร
    [Template]         level select document
    ข้อมูลทั่วไป
    [Teardown]         Close Browser

TC002-24 Level Document User Delete - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบเอกสารสอดคล้องระบบ เลือกลบระดับเอกสารที่มีสิทธิ์ และเช็คระดับเอกสาร
    [Template]         Document System User Delete
    ISO9001
    [Teardown]         Close Browser

TC002-25 Level Document User Add - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบเอกสารสอดคล้องระบบ เลือกเพิ่มระดับเอกสาร และเช็คระดับเอกสารที่มีสิทธิ์
    [Template]         Document System User
    ISO9001
    [Teardown]         Close Browser