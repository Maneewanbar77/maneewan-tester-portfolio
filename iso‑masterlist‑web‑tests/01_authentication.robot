***Settings***
Library           SeleniumLibrary
Resource          ${CURDIR}/00_variables.robot
Resource          ${CURDIR}/05_keywords_common.robot


***Test Cases***      
TC001-1 User And Password Login - Fail
    [Tags]    Done
    [Documentation]    ตรวจสอบกรณีกรอก User Password ไม่ถูกต้อง
    [Template]         Verify Input User And Password Login - Fail
    ${EMPTY}           ${EMPTY}
    ${EMPTY}           admin
    admin              ${EMPTY}    
    admin              P@ss       
    000000000          admin
    12347              Password


TC001-2 User And Password Login - Pass
    [Tags]    Done
    [Documentation]    ตรวจสอบการเข้าสู่ระบบ
    Run Keywords
    ...    Verify Input User And Password Login - Pass
    ...  AND
    ...    Close Browser

TC001-3 User Logout - Pass
    [Tags]    
    [Documentation]    ตรวจสอบการออกจากระบบ
    Verify Input User And Password Login - Pass
    Verify Check Log Out - Pass


