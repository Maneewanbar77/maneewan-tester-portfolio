# ISO MasterList Web Automation Tests (Robot Framework)

End‑to‑end test suites for an **internal ISO document‑control & master‑list application** (non‑public).  
The tests cover authentication, department setup, document‑type configuration, confidentiality levels, review/storage schedules, and the full document‑lifecycle workflow.

## 🔍 Test Scope
- Positive & negative user authentication flows  
- Add / edit / delete departments  
- Configure document types and prevent duplicates  
- Manage confidentiality levels and review frequencies  
- Register new documents with file upload & metadata validation  
- Search, filter, and view document history  
- Edit versions and delete documents with confirmation alerts  
- Global SweetAlert / toast verification for every critical action

## 🛠️ Tools & Technology
- Robot Framework
- SeleniumLibrary
- Chrome / Chromium WebDriver

## 📂 Project Structure
```
📁 iso-masterlist-web-tests/
├── README.md
└── robot/
    ├── 00_variables.robot             # Global variables & URLs
    ├── 01_authentication.robot        # Login / Logout
    ├── 02_department_management.robot # Department CRUD
    ├── 03_document_type_management.robot   # Document‑type CRUD & duplicate‑guard
    ├── 04_document_lifecycle.robot    # Create / edit / delete docs
    ├── 05_keywords_common.robot       # Shared keywords
    ├── 06_keywords_department.robot   # Department‑specific keywords
    ├── 07_keywords_document.robot     # Document‑related keywords
    └── 08_keywords_alerts.robot       # Alert helpers

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
