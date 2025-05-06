# Enterprise Doc‑Management Web Automation Tests (Robot Framework)

End‑to‑end test suites for an **internal document & access‑control web application** (non‑public).  
The tests cover authentication, role/holiday administration, user‑role matrices, file reception, real‑time job monitoring, and summary reports.

## 🔍 Test Scope
- Positive & negative user authentication flows
- Create / read / update / delete roles
- Create / update / delete company‑wide holidays (date‑picker logic)
- Export user‑role matrix and verify file download
- Filter and search activity logs by date, user and action
- Search received files by status and date range
- Locate processing jobs in the transaction monitor and open detail pane
- Generate summary reports within a date range and verify table totals

## 🛠️ Tools & Technology
- Robot Framework
- SeleniumLibrary
- Chrome / Chromium WebDriver

## 📂 Project Structure
```
📁 enterprise-doc-management-web-tests/
├── README.md
└── robot/                   
    ├── 01_roles_management.robot      # Roles
    ├── 02_roles_management_alt.robot  # Roles (alt)
    ├── 03_company_holidays.robot      # Holidays
    ├── 04_user_matrix_export.robot    # User Matrix
    ├── 05_activity_logs.robot         # Activity Logs
    ├── 06_received_files.robot        # Received Files
    ├── 07_transaction_monitor.robot   # Transactions
    └── 08_summary_report.robot        # Summary Report
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
robot 01_roles_management.robot
```
