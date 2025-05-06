***Settings***
Library           SeleniumLibrary
Suite Setup       Open Test Master
Resource          ${CURDIR}/00_variables.robot
Resource          ${CURDIR}/05_keywords_common.robot
Resource          ${CURDIR}/07_keywords_document.robot
Suite Teardown    Close All Browsers

***Test Cases***
## ตั้งค่าเอกสาร / ประเภทเอกสาร

TC003-1 Verify Search Filters Document Type - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูลประเภทเอกสาร เช็คผลลัพน์ในตาราง
    [Template]         Verify Search Filters Document Type - Pass
    QA1    QA ทดสอบเอกสาร1    QA Test Document1    ปกติ
    [Teardown]         Run Keywords    Verify clear Filters Document Type - Pass    AND    Close Browser

TC003-2 Verify Add Document Type - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการเพิ่มข้อมูลประเภทเอกสาร ไม่กรอกรายละเอียด ระบบแจ้งเตือนกรอบสีแดง
    [Template]         Add Document Type
    ${EMPTY}    ${EMPTY}    ${EMPTY}    QMR    ${EMPTY}    ${EMPTY}
    [Teardown]         Run Keyword    Close Browser

TC003-3 Verify Add Document Type - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการเพิ่มข้อมูลประเภทเอกสาร กรอกรายละเอียดถูกต้อง
    [Template]         Add Document Type
    Test1    เทส1    robot    QMR    ${EMPTY}    ${EMPTY}
    [Teardown]         Run Keywords    Check Alert    เพิ่มข้อมูลสำเร็จ!    ${EMPTY}    AND    Close Browser

TC003-4 Verify Add Document Type - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการเพิ่มข้อมูลประเภทเอกสาร กรอกรายละเอียดซ้ำ ระบบแจ้งเตือน รหัสประเภทเอกสาร 'Test1' ซ้ำ! กรุณาตรวจสอบ.
    [Template]         Add Document Type
    Test1    เทส1    robot    QMR    ${EMPTY}    ${EMPTY}
    [Teardown]         Run Keywords    Check Alert    ${EMPTY}    รหัสประเภทเอกสาร 'Test1' ซ้ำ! กรุณาตรวจสอบ.    AND    Close Browser

TC003-5 Verify Edit Add Document Type - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลประเภทเอกสาร ไม่กรอกรายละเอียด ระบบแจ้งเตือนกรอบสีแดง
    Run Keyword        Verify Search Filters Document Type - Pass    Test1    เทส1    robot    ปกติ
    Run Keyword        Edit Add Document Type    ${EMPTY}    ${EMPTY}    QMR    ${EMPTY}    ${EMPTY}
    Run Keyword        Close Browser

TC003-6 Verify Edit Add Document Type - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลประเภทเอกสาร กรอกรายละเอียด ระบบแจ้งเตือนบันทึกข้อมูลสำเร็จ!
    Run Keyword        Verify Search Filters Document Type - Pass    Test1    เทส1    robot    ปกติ
    Run Keyword        Edit Add Document Type    เทส2        robot       QMR    ${EMPTY}    ${EMPTY}
    Run Keyword        Close Browser

TC003-7 Verify Delete Document Type - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการลบข้อมูลประเภทเอกสาร ระบบแจ้งเตือน ยืนยัน! คลิกปุ่มยกเลิก และคลิกปุ่มตกลง
    Run Keyword        Verify Search Filters Document Type - Pass    Test1    เทส2    robot    ปกติ
    Run Keyword        Delete Document Type


# ตั้งค่าเอกสาร / ระดับชั้นความลับ

TC003-8 Verify Add Document Type Level - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-ระดับชั้นความลับ ไม่ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document Type Level
    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    PUB    ข้อมูลทั่วไป (Public)    Public    ตัวแทนฝ่ายบริหาร
    [Teardown]         Close Browser

TC003-9 Verify Add Document Type Level - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-ระดับชั้นความลับ ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document Type Level
    Test    โรบอท    Robot    DCC
    [Teardown]         Run Keywords        Check Alert    เพิ่มข้อมูลสำเร็จ!    ${EMPTY}    AND    Close Browser

TC003-10 Verify Search Filters Document Type Level - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูลระดับชั้นความลับ เช็คผลลัพน์ในตาราง
    [Template]         Verify Search Filters Document Type Level
    Test    โรบอท    Robot    ปกติ
    [Teardown]         Run Keywords    Verify clear Filters Document Type - Pass    AND    Close Browser

TC003-11 Edit Add Document Type Level - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลระดับชั้นความลับ ไม่ถูกต้อง ระบบแสดงกรอบสีแดงแจ้งเตือน
    Run Keyword        Verify Search Filters Document Type Level    Test        โรบอท    Robot    ปกติ
    Run Keyword        Edit Add Document Type Level                 ${EMPTY}    ปกติ      ${EMPTY}
    Run Keyword        Close Browser

TC003-12 Edit Add Document Type Level - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลระดับชั้นความลับ เช็คผลลัพน์ในตาราง
    Run Keyword        Verify Search Filters Document Type Level    Test        โรบอท    Robot    ปกติ
    Run Keyword        Edit Add Document Type Level                 โรบอท1      ปกติ      DCC
    Run Keyword        Check Alert                                  บันทึกข้อมูลสำเร็จ!       ${EMPTY}
    Run Keyword        Verify Search Filters Document Type Level    Test        โรบอท1    Robot    ปกติ
    Run Keywords       Verify clear Filters Document Type - Pass    AND    Close Browser    

#TC003-13 Delete Add Document Type Level - Pass
    # [Tags]    Done
    # [Documentation]    ตรวจสอบการลบข้อมูลระดับชั้นความลับ เช็คผลลัพน์ในตาราง


# ตั้งค่าเอกสาร / ความถี่การรีวิวเอกสาร

TC003-14 Verify Add Document Review - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-ความถี่การรีวิวเอกสาร ไม่ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document Review
    6-month     ทุก 6 เดือน        
    ${EMPTY}    ${EMPTY}       
    [Teardown]         Close Browser

TC003-15 Verify Add Document Review - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-ความถี่การรีวิวเอกสาร ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document Review
    Test7     Robot
    [Teardown]         Run Keyword    Close Browser

TC003-16 Verify Search Filters Document Review - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูลความถี่การรีวิวเอกสาร เช็คผลลัพน์ในตาราง และคลิกปุ่มเคลียร์
    [Template]         Verify Search Filters Document Review
    Test7    Robot     ปกติ
    [Teardown]         Run Keywords    Verify clear Filters Document Type - Pass    AND    Close Browser

TC003-17 Edit Add Document Review - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลความถี่การรีวิวเอกสาร ไม่ถูกต้อง ระบบแสดงกรอบสีแดงแจ้งเตือน
    Run Keyword        Verify Search Filters Document Review    Test7       Robot     ปกติ
    Run Keyword        Edit Add Document Review                 ${EMPTY}    ปกติ      
    Run Keyword        Close Browser

TC003-18 Edit Add Document Review - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลความถี่การรีวิวเอกสาร เช็คผลลัพน์ในตาราง
    Run Keyword        Verify Search Filters Document Review    Test7       Robot     ปกติ
    Run Keyword        Edit Add Document Review                 Test8       ปกติ
    Run Keyword        Check Alert                              บันทึกข้อมูลสำเร็จ!       ${EMPTY}
    Run Keyword        Verify Search Filters Document Review    Test8       Robot     ปกติ
    Run Keyword        Close Browser    

#TC003-19 Delete Add Document Review - Pass
    # [Tags]    Done
    # [Documentation]    ตรวจสอบการลบข้อมูลความถี่การรีวิวเอกสาร เช็คผลลัพน์ในตาราง

# ตั้งค่าเอกสาร / ระยะเวลาในการจัดเก็บเอกสาร

TC003-20 Verify Add Document Time - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-ระยะเวลาในการจัดเก็บเอกสาร ไม่ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document Time
    1-year      1 ปี        
    ${EMPTY}    ${EMPTY}       
    [Teardown]         Close Browser

TC003-21 Verify Add Document Time - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-ระยะเวลาในการจัดเก็บเอกสาร ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document Time
    Tst       Robot     
    [Teardown]         Run Keyword    Close Browser

TC003-22 Verify Search Filters Document Time - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูลระยะเวลาในการจัดเก็บเอกสาร เช็คผลลัพน์ในตาราง และคลิกปุ่มเคลียร์
    [Template]         Verify Search Filters Document Time
    Tst       Robot    ปกติ 
    [Teardown]         Run Keywords    Verify clear Filters Document Type - Pass    AND    Close Browser


TC003-23 Edit Add Document Time - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลระยะเวลาในการจัดเก็บเอกสาร ไม่ถูกต้อง ระบบแสดงกรอบสีแดงแจ้งเตือน
    Run Keyword        Verify Search Filters Document Time      Tst         Robot    ปกติ
    Run Keyword        Edit Add Document Time                   ${EMPTY}    ปกติ      
    Run Keyword        Close Browser

TC003-24 Edit Add Document Time - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลระยะเวลาในการจัดเก็บเอกสาร เช็คผลลัพน์ในตาราง
    Run Keyword        Verify Search Filters Document Time      Tst       Robot      ปกติ
    Run Keyword        Edit Add Document Time                             Robot1     ปกติ
    Run Keyword        Verify Search Filters Document Time      Tst       Robot1     ปกติ
    Run Keyword        Close Browser   

TC003-25 Delete Add Document Time - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการลบข้อมูลระยะเวลาในการจัดเก็บเอกสาร คลิกปุ่มยกเลิก และคลิกปุ่มตกลง
    Run Keyword        Verify Search Filters Document Time      Tst       Robot1     ปกติ
    Run Keyword        Delete Add Document Time

## ตั้งค่าเอกสาร / เอกสารสอดคล้องกับระบบ

TC003-26 Verify Add Document System - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-เอกสารสอดคล้องกับระบบ ไม่ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document System
    Test        ทดสอบเอกสาร     
    ${EMPTY}    ${EMPTY}       
    [Teardown]         Close Browser          

TC003-27 Verify Add Document System - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการกรอกข้อมูล เพิ่ม-เอกสารสอดคล้องกับระบบ ถูกต้อง ระบบทำการแจ้งเตือน
    [Template]         Add Document System
    Tst       Robot         
    [Teardown]         Close Browser       

TC003-28 Verify Search Filters Document System - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการค้นหาข้อมูลเอกสารสอดคล้องกับระบบ เช็คผลลัพน์ในตาราง และคลิกปุ่มเคลียร์
    [Template]         Verify Search Filters Document System
    Tst       Robot    ปกติ 
    [Teardown]         Run Keywords    Verify clear Filters Document Type - Pass    AND    Close Browser  

TC003-29 Edit Add Document System - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลเอกสารสอดคล้องกับระบบ ไม่ถูกต้อง ระบบแสดงกรอบสีแดงแจ้งเตือน
    Run Keyword        Verify Search Filters Document System      Tst         Robot    ปกติ
    Run Keyword        Edit Add Document Time                     ${EMPTY}    ปกติ      
    Run Keyword        Close Browser

TC003-30 Edit Add Document System - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการแก้ไขข้อมูลเอกสารสอดคล้องกับระบบ เช็คผลลัพน์ในตาราง
    Run Keyword        Verify Search Filters Document System      Tst       Robot      ปกติ
    Run Keyword        Edit Add Document Time                               Robot1     ปกติ
    Run Keyword        Verify Search Filters Document System      Tst       Robot1     ปกติ
    Run Keyword        Close Browser   

TC003-31 Delete Add Document System - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการลบข้อมูลเอกสารสอดคล้องกับระบบ คลิกปุ่มยกเลิก และคลิกปุ่มตกลง
    Run Keyword        Verify Search Filters Document System      Tst       Robot1     ปกติ
    Run Keyword        Delete Add Document Time