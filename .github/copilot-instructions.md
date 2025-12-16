# Copilot Instructions for ZAP API Integration

## Project Overview

This repository integrates the OWASP Zed Attack Proxy (ZAP) API for automated vulnerability scanning with an AI analysis layer that classifies and prioritizes security vulnerabilities. The project is designed as a security scanning tool with intelligent analysis capabilities.

## Repository Structure

```
.
├── .github/                        # GitHub configuration
│   └── copilot-instructions.md    # This file
├── /docs                           # Documentation and implementation files
│   ├── /docs                       # User-facing documentation
│   │   ├── AI_ANALYSIS.md         # AI analysis layer documentation
│   │   ├── INSTALLATION.md        # Setup and installation guide
│   │   ├── USAGE.md               # User guide
│   │   └── TROUBLESHOOTING.md     # Common issues and solutions
│   ├── /scripts                    # Implementation scripts
│   │   ├── /src                   # Backend source code
│   │   │   └── routes.py          # Flask API routes
│   │   └── zapApi.js              # Node.js ZAP API client
│   └── README.md                  # Documentation index
└── README.md                       # Main project README
```

## Technology Stack

### Backend
- **Python**: Flask framework for REST API endpoints
- **Node.js**: JavaScript runtime for ZAP API client operations
- **ZAP API**: Core security scanning integration

### Key Dependencies
- Python: `flask`, `requests`, `json`
- Node.js: `axios` for HTTP requests

## Coding Standards

### Python Code (Flask Backend)
- Follow **PEP 8** style guidelines
- Use descriptive variable names (e.g., `target_url`, `scan_id`, `severity_mapping`)
- Include docstrings for functions explaining their purpose
- Use meaningful route paths (e.g., `/start_scan`, `/scan_results/<scan_id>`)
- Handle errors gracefully with appropriate HTTP status codes
- Configuration values (API URLs, keys) should be defined as constants at the top of files

### JavaScript Code (ZAP Client)
- Use **async/await** for asynchronous operations
- Export functions using `module.exports` for reusability
- Include error handling with try-catch blocks
- Use template literals for string interpolation
- Add console logging for important operations

### General Guidelines
- **Security**: Never commit API keys or sensitive credentials to version control
- **Comments**: Add comments to explain complex logic, especially in the AI analysis functions
- **Error Handling**: Always provide meaningful error messages to help with debugging

## API Endpoints

The Flask backend implements the following REST API pattern:

### POST /start_scan
- Accepts JSON with `target_url` field
- Returns `scan_id` for tracking the scan

### GET /scan_results/<scan_id>
- Returns alerts and AI-generated insights
- Includes vulnerability classification and prioritization

## AI Analysis Layer

The AI analysis functionality is implemented in the `analyze_results()` function in `routes.py`:

- **Severity Mapping**: High=3, Medium=2, Low=1, Informational=0
- **Classification**: Counts issues by severity level
- **Prioritization**: Extracts top issues (High/Medium severity) with key details
- When modifying AI logic, maintain the insights structure for API consistency

## ZAP Configuration

The project integrates with ZAP running locally:
- **Default URL**: `http://127.0.0.1:8080` (localhost)
- Note: The Node.js client in `zapApi.js` uses `http://192.168.10.10:8080` - this should be updated to match your local ZAP instance IP address
- **API endpoints used**:
  - `/JSON/ascan/action/scan/` - Start active scan
  - `/JSON/core/view/alerts/` - Retrieve alerts
  - `/JSON/ascan/view/scanProgress/` - Check scan progress

## Documentation Requirements

When making changes:

1. **Code Changes**: Update relevant documentation in `/docs/docs/` if modifying:
   - Installation steps → `INSTALLATION.md`
   - Usage instructions → `USAGE.md`
   - AI functionality → `AI_ANALYSIS.md`
   - Issues/fixes → `TROUBLESHOOTING.md`

2. **New Features**: Document new API endpoints, configuration options, or workflows

3. **README Updates**: Keep the main `README.md` in sync with major architectural changes

## Development Workflow

### Prerequisites
- Kali Linux (or compatible environment)
- ZAP installed and running
- Python 3.x installed
- Node.js and npm installed

### Setup
1. Install ZAP and configure the API (see `docs/docs/INSTALLATION.md`)
2. Enable ZAP API at `Tools > Options > API`
3. Note the API key and configure it in the code files
4. Install Python dependencies (if `requirements.txt` exists)
5. Install Node.js dependencies (if `package.json` exists)

### Running the Application
- **Flask Backend**: `python docs/scripts/src/routes.py`
- The application runs in debug mode by default (`debug=True`)

### Testing
- Verify ZAP is running: Navigate to `http://localhost:8080/JSON/core/view/version/`
- Test API endpoints using tools like Postman or curl
- Validate AI analysis output for different vulnerability types

## Security Considerations

- **API Keys**: Always use environment variables or secure configuration for API keys
- **Input Validation**: Validate all target URLs before starting scans
- **Rate Limiting**: Consider implementing rate limiting for scan endpoints
- **Credentials**: The repository contains example API keys that should be replaced with actual keys in production

## Common Tasks

### Adding a New Scan Type
1. Add new route in `routes.py`
2. Implement ZAP API call for the scan type
3. Update `analyze_results()` if different analysis is needed
4. Document the new endpoint in `docs/docs/USAGE.md`

### Modifying AI Analysis
1. Update the `analyze_results()` function in `routes.py`
2. Maintain backward compatibility with the insights structure
3. Document changes in `docs/docs/AI_ANALYSIS.md`
4. Test with various vulnerability datasets

### Adding Documentation
1. Place new documentation files in `docs/docs/`
2. Update `docs/README.md` to reference the new documentation
3. Use clear markdown formatting with code examples

## Issue Resolution Guidelines

When working on issues:
- **Bug Fixes**: Focus on minimal changes to fix the specific issue
- **Features**: Follow existing code patterns and structure
- **Documentation**: Update related docs alongside code changes
- **Security**: Run ZAP scans on modified endpoints to ensure no new vulnerabilities

## Notes for Copilot

- This is a security-focused project, so prioritize secure coding practices
- The codebase is relatively simple and serves as an educational example
- Maintain consistency with existing patterns (Flask routes, async/await in JS)
- When in doubt about ZAP API usage, refer to the official OWASP ZAP API documentation
- The AI analysis is currently rule-based; future enhancements might include ML models
