***Settings***
Library           SeleniumLibrary
Suite Setup       Open Test Master
Resource          ${CURDIR}/00_variables.robot
Resource          ${CURDIR}/05_keywords_common.robot
# Resource          ${CURDIR}/CSP_Keyword_Detail3.robot
Resource          ${CURDIR}/08_keywords_alerts.robot
Suite Teardown    Close All Browsers

*** Test Cases ***
TC04-001 Verify Input New Document - Pass
    [Tags]    Done
    [Documentation]  ตรวจสอบการกรอกข้อมูลขึ้นทะเบียนเอกสารใหม่ถูกต้อง
    Run Keyword      Add New Document     โรบอทเอกสาร9    Form    IT    2    ทั่วไป    ทุก 6 เดือน    1 ปี
    Run Keyword      Handle Checkboxes    2
    Run Keyword      Upload File1
    Run Keyword      Save Input New Document 
    Run Keywords     Select Operation     ส่งหัวหน้าแผนกอนุมัติ    AND    Close Browser


TC04-002 Verify Input New Document - Fail
    [Tags]    Done
    [Documentation]  ตรวจสอบกรอบแจ้งเตือนการไม่กรอกข้อมูลขึ้นทะเบียนเอกสารใหม่
    [Template]       Add New Document Error Border 
    ${EMPTY}         ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    [Teardown]       Close Browser
    

TC04-003 Verify Search Document - Pass
    [Tags]    Done
    [Documentation]  ตรวจสอบการกรอกข้อมูลในการค้นหา และแสดงข้อมูลในตารางถูกต้อง
    Run Keyword      Open Document 101670066
    Run Keyword      Search Document    FM-ITS-18    QA คู่มือเอกสาร 5    Form (แบบฟอร์ม)    IT Software    ${EMPTY}    ข้อมูลทั่วไป    ปกติ        ขอทบทวนเอกสาร    ${EMPTY}
    Run Keywords     Clear Search Document
    Run Keyword      Search Document    ${EMPTY}     xxx               ${EMPTY}          ${EMPTY}       ${EMPTY}     ${EMPTY}    ${EMPTY}    ${EMPTY}         ${EMPTY}
    Run Keywords     Clear Search Document    AND    Close Browser

 
TC04-004 Verify Edit Document - Pass
    [Tags]    Done
    [Documentation]  ตรวจสอบการแก้ไขข้อมูลรายละเอียดเอกสาร
    Run Keyword      Open Document 101670066
    Run Keyword      Search Document      ${EMPTY}       โรบอทเอกสาร5    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}     ${EMPTY}    ${EMPTY}    ${EMPTY}
    Run Keyword      Edit Document        โรบอทเอกสาร5    Form           IT          2           ทั่วไป        ทุก 6 เดือน    1 ปี
    Run Keyword      Handle Checkboxes    3
    Run Keyword      Upload File2
    Run Keywords     Select Operation     ${EMPTY}    AND    Close Browser


TC04-005 Verify Approve Document Form - Pass
    [Tags]    Done
    [Documentation]  ตรวจสอบการอนุมัติเอกสารตามลำดับสิทธิ์
    Run Keyword      Approve Document Form 1
    Run Keyword      Approve Document Form 2
    Run Keyword      Approve Document Form 3

TC04-006 Verify History Document - Pass
    [Tags]    Done
    [Documentation]  ตรวจสอบประวัติการดำเนินเอกสาร
    Run Keyword      Open Document 101610048
    Run Keyword      Search Document     ${EMPTY}    ทดสอบโรบอท02    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}     ${EMPTY}    ${EMPTY}    ${EMPTY}
    Run Keywords     History Document    AND   Close Browser


TC04-007 Verify Delete New Document - Pass
    [Tags]    Done
    [Documentation]  ตรวจสอบการลบเอกสารขึ้นทะเบียนใหม่ กรณีที่เป็นเอกสารใหม่ ยังไม่ส่งดำเนินการ
    Run Keyword      Open Document 101670066
    Run Keyword      Search Document     ${EMPTY}    โรบอท001    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}     ${EMPTY}    ${EMPTY}    ${EMPTY}
    Run Keywords     Delete Document    AND    Close All Browsers
