# Zap-api-integration With AI Analysis
Overview
This project integrates the OWASP Zed Attack Proxy (ZAP) API for automated vulnerability scanning into a web application, enhanced with an AI analysis layer to classify and prioritize vulnerabilities. The backend is built using Python's Flask framework, and the frontend interacts with the backend to initiate scans, retrieve results, and display AI-generated insights.

Features
Automated Vulnerability Scanning: Start and manage security scans using the ZAP API.
AI-Powered Analysis: Analyze scan results using AI to classify and prioritize vulnerabilities based on severity, type, and potential impact.
User-Friendly Interface: Simple routes and components to interact with the scanning and analysis features.
Project Structure
bash
Copy code
/my-zap-api-project
├── /docs
│   ├── API_Documentation.md
│   ├── AI_Analysis_Explanation.md
│   └── Setup_Guide.md
├── /src
│   ├── routes.py
│   └── other_files.py
└── README.md
How to Set Up
Prerequisites
Kali Linux with ZAP installed
Python 3.x and Flask installed
Node.js and npm for frontend components
Postman for API testing (optional but recommended)
1. Clone the Repository
bash
Copy code
git clone https://github.com/your-username/my-zap-api-project.git
cd my-zap-api-project
2. Install Python Dependencies
Navigate to the src/ directory and install the required Python packages:

bash
Copy code
cd src
pip install -r requirements.txt
3. Configure ZAP API
Ensure ZAP is running on your Kali Linux machine and accessible via 127.0.0.1:8080. Replace the placeholder API key in the routes.py file with your actual ZAP API key.

python
Copy code
ZAP_API_URL = "http://127.0.0.1:8080"
ZAP_API_KEY = "toflfn0oq4m3koeggqh89n5e3s"
4. Run the Flask Server
bash
Copy code
python routes.py
The server will start on http://127.0.0.1:5000.

5. Interact with the API
Use Postman or your preferred API client to interact with the endpoints. For example, to start a scan:

Endpoint: POST /start_scan
Body: {"target_url": "http://example.com"}
6. View Scan Results and AI Analysis
Retrieve and analyze scan results with the following endpoint:

Endpoint: GET /scan_results/<scan_id>
The response will include both the raw scan data and AI-generated insights.

Explanation
ZAP API Integration
The project uses the ZAP API to initiate and manage vulnerability scans. The API is integrated through a set of Flask routes that handle requests to start scans, retrieve results, and process those results.

AI Analysis Layer
The AI analysis layer processes the scan results to prioritize vulnerabilities. It uses a simple rule-based system to classify issues by severity and highlight the most critical vulnerabilities. Future enhancements could include more advanced machine learning models for deeper analysis.

Documentation
For more detailed information on the API routes and AI analysis, see the documentation in the docs/ folder:

API Documentation
AI Analysis Explanation
Setup Guide
