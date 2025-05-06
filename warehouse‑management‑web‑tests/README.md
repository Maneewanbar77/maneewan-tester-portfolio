# Warehouse Management Web Automation Tests (Robot Framework)

End‑to‑end test suites for an **internal warehouse‑management & access‑control application** (non‑public).  
The suites cover authentication, password change, user‑account administration, and role/permission configuration.

## 🔍 Test Scope
- Positive & negative login flows with password‑visibility toggle  
- Change‑password workflow (invalid formats, duplicate checks, success)  
- Create / edit / delete / search user accounts  
- Assign & revoke roles, verify SweetAlert confirmations  
- Logout and session‑timeout validation

## 🛠️ Tools & Technology
- Robot Framework
- SeleniumLibrary
- Chrome / Chromium WebDriver

## 📂 Project Structure
```
📁 warehouse-management-web-tests/
├── README.md
└── robot/
    ├── 01_authentication.robot # Login / Logout
    ├── 02_change_password.robot # Change‑password scenarios
    ├── 03_user_management.robot # User CRUD & search
    └── 04_role_permission.robot # Role & permission config

```

## ▶️ How to Run Tests

### 1. Install dependencies
```bash
pip install robotframework selenium
```

###  2. Download ChromeDriver
Make sure the version matches your Chrome browser
Place it in your PATH or specify with --variable BROWSER:Chrome

###  3. Run the test
```bash
robot 01_authentication.robot
```
