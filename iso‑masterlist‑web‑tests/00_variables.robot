***Settings***
Library    SeleniumLibrary


***Variables***
${url}      http://Test.com
${browser}  chrome

#LOGIN & LOGOUT PASS
${locator_inputUser}                name=UserName
${locator_inputPass}                name=Password
${locator_btnLogin}                 xpath=//*[@id="wrapper"]/div/div/div/form/div[4]/div/button
${locator_User}                     xpath=/html/body/div[2]/nav/ul[2]/li[2]/a
${locator_Logout}                   xpath=/html/body/div[2]/nav/ul[2]/li[2]/div/span/a

#LOGIN & LOGOUT FAIL
${locator_msg_User}                 xpath=//*[@id="wrapper"]/div/div/div/form/div[2]/div/span
${locator_msg_Pass}                 xpath=//*[@id="wrapper"]/div/div/div/form/div[3]/div/span
${locator_msg_UserPass}             xpath=//*[@id="wrapper"]/div/div/div/form/div[4]/ul/li
${locator_msg_loginFail}            xpath=//*[@id="modalMessage"]/div/div/div[1]/h2/strong/label
${locator_msg_Alert}                xpath=//*[@id="modalMessage"]/div/div/div[3]/button
${locator_alert_Popup}              xpath=//*[@id="modalMessage"]/div

#MENU
${locator_Menu}                     xpath=/html/body/div[2]/nav/ul[1]/li/a
#ALERT POPUP
${locator_Alert}                    xpath=//h2[@class='swal2-title']
${locator_Alert2}                   id=swal2-content
${locator_ok_alert}                 xpath=/html/body/div[7]/div/div[3]/button[1]
${locator_cancle_alert}             xpath=/html/body/div[7]/div/div[3]/button[2]
${locator_cancle_alert2}            xpath=/html/body/div[8]/div/div[3]/button[2]
${locator_ok_alert2}                xpath=/html/body/div[8]/div/div[3]/button[1]

#ตั้งค่าระบบ
${locator_setting_System}           xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[1]/a


#แผนก
${locator_system_Department}        xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[1]/ul/li[1]/a
${locator_department_Add}           xpath=//*[@id="tbDetaillist"]/thead/tr/th[9]/button
${locator_popup_Addepartment}       xpath=//*[@id="divModal"]
${locator_add_Iddepart}             id=txtCodeModal
${locator_add_namedepartTh}         id=txtNameTHModal
${locator_add_namedepartEn}         id=txtNameENModal
${locator_add_Btndepart}            id=btnSave
${locator_table_Department}         xpath=//*[@id="tbDetaillist"]/tbody

${locator_select_status}            xpath=//*[@id="ddlStatusSearch"]
${locator_search_Id}                id=txtCode
${locator_search_Name}              id=txtNameTH
${locator_search_btn}               xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[3]/div[2]/button
${locator_search_clear}             xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[3]/div[3]/button
${locator_edit_namedepartTh}        id=txtNameTHModal
${locator_edit_Department}          xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[9]/a[1]
${locator_delete_Department}        xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[9]/a[2]/span


#สิทธิ์การใช้งาน
${locator_system_License}           xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[1]/ul/li[2]/a
${locator_license_Add}              xpath=//*[@id="btnNewRole"]
${locator_popup_addlicense}         id=modalTitle
#สิทธิ์การใช้งาน / เพิ่ม
${locator_add_Idlicense}            id=txtModalRoleCode
${locator_add_namelicenseTh}        id=txtModalRoleNameThai    
${locator_add_namelicenseEn}        id=txtModalRoleNameEng
${locator_add_Btnlicense}           id=btnSave
${locator_add_Rolelicense}          id=ddlRoleLevelModal
${locator_add_Rolestatusli}         id=ddlIsActiveModal
#สิทธิ์การใช้งาน / ค้นหา
${locator_search_Idlicense}         id=txtRoleCode
${locator_search_Namelicense}       id=txtRoleNameTh
${locator_search_Rolelicense}       id=ddlRoleLevel
${locator_search_Btnlicense}        xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[2]/div[4]/button
${locator_search_clearlicense}      xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[2]/div[5]/button
${locator_table_license}            xpath=//*[@id="tbRoleShowlist"]/tbody
#สิทธิ์การใช้งาน / รายละเอียด
${locator_edit_license}             xpath=//*[@id="tbRoleShowlist"]/tbody/tr[1]/td[9]/a[1]/span
#สิทธิ์การใช้งาน / ฟังก์ชัน
${locator_btn_functionli}           xpath=//*[@id="tbRoleShowlist"]/tbody/tr[1]/td[9]/a[2]/span
${locator_btnad_functionli}         xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/button/i
${locator_selectad_outfunctionli}   id=selectListFunctionWithOutRole
${locator_selectad_functionli}      xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/button/i
${locator_btnde_functionli}         xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[3]/td[2]/table/tbody/tr/td/button/i
${locator_selectde_infunctionli}    id=selectListFunctionWithInRole
${locator_selectco_functionli}      xpath=//*[@id="dialogContent"]/div[3]/button
#สิทธิ์การใช้งาน / ลบ
${locator_delete_License}           xpath=//*[@id="tbRoleShowlist"]/tbody/tr[1]/td[9]/a[3]/span


#ผู้ใช้งาน 
${locator_system_User}              xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[1]/ul/li[3]/a

${locator_search_Iduser}            id=txtUsernameSearch
${locator_search_Nameuser}          id=txtFirstnameTh
${locator_search_Deuser}            id=ddlDepartmentSearch
${locator_search_Statususer}        id=ddlSelectStatusSearch
${locator_search_Btnuser}           xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[4]/div[2]/button/i
${locator_table_User}               id=tbDetaillist
${locator_search_clearuser}         xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[4]/div[4]/button/i
${locator_edit_user}                xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[14]/a[1]/span
${locator_btn_save}                 id=btnSave
${locator_edit_ucompany}            id=ddlCorporateModal
${locator_edit_unamecom}            id=ddlCompanyModal
${locator_edit_ulicense}            id=ddlRoleModal
${locator_edit_udepart}             id=ddlDepartmentModal
${locator_edit_unameth}             id=txtFirstNameTHModal
${locator_edit_ulastth}             id=txtLastNameTHModal

${locator_btn_Userli}               xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[14]/a[2]/span
${locator_add_Usercom}              id=ddlCompanyPermission
${locator_add_Userde}               id=ddlDepartmentPermission
${locator_add_Userli}               id=ddlRolePermission
${locator_btn_addsave}              id=btnSaveUserPermission
${locator_edit_btnuser}             xpath=//*[@id="tbDetaillistPermissionModal"]/tbody/tr[1]/td[5]/a[1]
${locator_edit_btnClear}            xpath=//*[@id="dialogContent"]/div[2]/div[2]/div[4]/div[4]/button
${locator_edit_btnDelete}           xpath=//*[@id="tbDetaillistPermissionModal"]/tbody/tr[1]/td[5]/a[2]/span
${locator_edit_btnclose}            xpath=//*[@id="dialogContent"]/div[3]/button

${locator_btn_level}                xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[14]/a[3]/span
${locator_btn_levelad}              xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/button/i
${locator_btn_levelde}              xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[3]/td[2]/table/tbody/tr/td/button/i
${locator_level_doc}                id=documentLevel
${locator_level_docse}              id=documentLevelSelect
${locator_btn_levelsys}             xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[14]/a[4]/span
${locator_document_Cor}             id=documentCorrespond
${locator_document_Secor}           id=documentCorrespondSelect
${locator_btnde_Secor}              xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[3]/td[2]/table/tbody/tr/td/button/i
${locator_btnde_Cor}                xpath=//*[@id="dialogContent"]/div[2]/div/table/tbody/tr[1]/td[2]/table/tbody/tr/td/button/i


${DOWNLOAD_PATH}    C:/Users/maneewan.b/Downloads
${EXPORTED_FILE}    ${DOWNLOAD_PATH}/


#ตั้งค่าเอกสาร
${locator_setting_Document}        xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[2]/a

#ประเภทเอกสาร
${locator_document_Doctype}        xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[2]/ul/li[1]/a
${locator_docsearch_Idtype}        id=txtCode
${locator_docsearch_Namethtype}    id=txtNameTH
${locator_docsearch_Nameentype}    id=txtNameEN
${locator_docsearch_Statustype}    id=ddlStatusSearch
${locator_btn_docsearch}           xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[3]/div[2]/button/i
${locator_btnclear_docsearch}      xpath=/html/body/div[2]/div[1]/section/div[2]/div/div/div/div[1]/div[3]/div[3]/button/i
${locator_table_Doctype}           id=tbDetaillist
#ประเภทเอกสาร / เพิ่ม-ประเภทเอกสาร
${locator_add_Doctype}             xpath=//*[@id="tbDetaillist"]/thead/tr/th[9]/button/i
${locator_add_idtype}              id=txtCodeModal
${locator_add_namethtype}          id=txtNameTHModal
${locator_add_nameentype}          id=txtNameENModal
${locator_add_detype}              id=ddlDivisionResponsible
${locator_add_cisotype}            id=ddlCISOApprove
${locator_add_ceotype}             id=ddlCEOApprove
#ประเภทเอกสาร / ลบ-ประเภทเอกสาร
${locator_delete_doctype}          xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[9]/a[2]/span
${locator_edit_btndoctype}         xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[9]/a[1]/span
## ตั้งค่าเอกสาร / ระดับชั้นความลับ / เพิ่ม
${locator_document_DocLevel}       xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[2]/ul/li[2]/a/i
${locator_add_doclevel}            xpath=//*[@id="tbDocLevel"]/thead/tr/th[10]/button/i
${locator_add_doclevel_ap}         id=ddlDocumentFlow
${locator_btn_editdoclevel}        xpath=//*[@id="tbDocLevel"]/tbody/tr[1]/td[10]/a/span

## ตั้งค่าเอกสาร / ความถี่การรีวิวเอกสาร
${locator_document_Review}         xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[2]/ul/li[3]/a
${locator_add_docReview}           xpath=//*[@id="tbDetaillist"]/thead/tr/th[9]/button/i
${locator_Close}                   xpath=/html/body/div[8]/div/div[1]/button
${locator_btn_editReview}          xpath=//*[@id="tbDetaillist"]/tbody/tr[1]/td[9]/a/span

## ตั้งค่าเอกสาร / ระยะเวลาในการจัดเก็บเอกสาร
${locator_document_time}           xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[2]/ul/li[4]/a

## ตั้งค่าเอกสาร / เอกสารสอดคล้องกับระบบ
${locator_document_System}         xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[2]/ul/li[5]/a


##ผู้ใช้งาน
${locator_manu_document}           xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[1]/a

${locator_document}                xpath=/html/body/div[2]/aside/div/div[4]/div/div/nav/ul/li[1]/ul/li[1]/a
${locator_document_btnsearch}      xpath=/html/body/div[2]/div[1]/section/div[3]/div/div/div/div[1]/div[4]/div[4]/button/i
${locator_btn_newdoc}              id=btnNewDocument
${locator_nameth_newdoc}           id=txtDocumentNameTH
${locator_type_newdoc}             id=ddlDocumentType
${locator_depart_newdoc}           id=ddlDepartment
${locator_page_newdoc}             id=txtTotalPage
${locator_level_newdoc}            id=ddlDocumentLevel
${locator_review_newdoc}           id=ddlReviewFrequency
${locator_time_newdoc}             id=ddlDurationStorageCancel
# ${locator_chkbox_xpath}            //input[@type='checkbox' and @class='col-md-12']
${locator_chkbox_newdoc}           id=CheckBoxList
# ${locator_file1_newdoc}            id:FileUpload1
# ${locator_file2_newdoc}            id:FileUpload2

#จัดทำเอกสาร
${CHECKBOXES}                      chk_ISO9001,chk_ISO14001,chk_ISO45001,chk_ISO27001,chk_ISO14298,chk_PCI-DSS,chk_CQM,chk_ETAX-EBTS,chk_PDPA,chk_Test
@{VALID_EXTENSIONS_FILE1}           doc    docx    xls    xlsx    ppt    pptx    vsd    vsdx
@{VALID_EXTENSION_FILE2}           pdf
${locator_file1_newdoc}     id=FileUpload1
${locator_file2_newdoc}     id=FileUpload2
${path_file1}     C:\\Users\\maneewan.b\\Desktop\\Folder\\CSP - Masterlist\\File Test\\Test document 4.docx
${path_file2}     C:\\Users\\maneewan.b\\Desktop\\Folder\\CSP - Masterlist\\File Test\\Test document 1.pdf
${path_file1.1}     C:\\Users\\maneewan.b\\Desktop\\Folder\\CSP - Masterlist\\File Test\\Test document 4_Rev.01.docx
${path_file2.1}     C:\\Users\\maneewan.b\\Desktop\\Folder\\CSP - Masterlist\\File Test\\Test document 1_Rev.01.pdf


#จัดทำเอกสาร / ค้นหาเอกสาร
${locator_searchid_newdoc}          id=txtDocumentCode
${locator_searchiso_newdoc}         id=ddlDocumentCorrespondSearch
${locator_searchleve_newdoc}        id=ddlDocumentLevelSearch
${locator_searchstatus_newdoc}      id=ddlDocumentStatusSearch
${locator_searchobject_newdoc}      id=ddlDocumentPhaseSearch
${locator_searchobject_newdoc}      id=ddlDocumentProcessSearch
${locator_table_newdoc}             id=tblDocumentList
${locator_searchname_newdoc}        id=txtDocumentName
${locator_searchtb_newdoc}          id=tblDocumentList
${locator_searchtype_newdoc}        id=ddlDocumentTypeSearch
${locator_clearbtn_newdoc}          xpath=/html/body/div[2]/div[1]/section/div[3]/div/div/div/div[1]/div[4]/div[5]/button/i

#จัดทำเอกสาร / แก้ไขเอกสาร
${locator_edittable_doc}            xpath=//*[@id="tblDocumentList"]/tbody/tr[1]/td[1]/a[1]/span
${locator_edit_Operation}           id=ddlDocumentTracking
${locator_table}                    id=tblDocumentNull
${locator_btn_History}              xpath=//*[@id="tblDocumentList"]/tbody/tr[1]/td[1]/a[2]/span
${locator_title_History}            id=modalTitle
${locator_close_History}            xpath=//*[@id="dialogContent"]/div[3]/button
${locator_delete_document}          xpath=//*[@id="tblDocumentList"]/tbody/tr[1]/td[1]/a[3]/span