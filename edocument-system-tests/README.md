# Document Management System Tests (Robot Framework)

This project includes automated test cases written using Robot Framework  
for a document management and e-signature web application (simulated project).

## 🔍 Test Scope
- User login via web interface
- Navigate through main menu
- Upload and manage documents
- Verify document approval/signing workflows

## 🛠️ Tools & Technology
- Robot Framework
- SeleniumLibrary
- Chrome / Chromium WebDriver

## 📂 Project Structure
```
📁 edocument-system-tests/
├── README.md
└── robot/
    └── 01_activity_logs_actions.robot # Activity Logs — search, filter, sort, duplicate‑guard
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
robot 01_activity_logs_actions.robot
```
