from flask import Flask, jsonify, request
import requests
import json

app = Flask(__name__)

# ZAP API Configuration
ZAP_API_URL = "http://127.0.0.1:8080"  # Replace with your ZAP instance URL
ZAP_API_KEY = "toflfn0oq4m3koeggqh89n5e3s"  # Replace with your ZAP API key

# Route to start a new scan
@app.route('/start_scan', methods=['POST'])
def start_scan():
    target_url = request.json.get('target_url')
    if not target_url:
        return jsonify({"error": "No target URL provided"}), 400

    # ZAP API call to start a new scan
    scan_url = f"{ZAP_API_URL}/JSON/ascan/action/scan/?url={target_url}&apikey={ZAP_API_KEY}"
    response = requests.get(scan_url)
    
    if response.status_code == 200:
        scan_id = response.json().get('scan')
        return jsonify({"message": "Scan started", "scan_id": scan_id}), 200
    else:
        return jsonify({"error": "Failed to start scan"}), 500

# Route to get scan results
@app.route('/scan_results/<scan_id>', methods=['GET'])
def get_scan_results(scan_id):
    # ZAP API call to retrieve scan results
    results_url = f"{ZAP_API_URL}/JSON/core/view/alerts/?baseurl=&scanId={scan_id}&apikey={ZAP_API_KEY}"
    response = requests.get(results_url)

    if response.status_code == 200:
        alerts = response.json().get('alerts')
        insights = analyze_results(alerts)  # AI Analysis
        return jsonify({"alerts": alerts, "insights": insights}), 200
    else:
        return jsonify({"error": "Failed to retrieve scan results"}), 500

# AI analysis function to process ZAP scan results
def analyze_results(alerts):
    # Simple AI logic to classify and prioritize vulnerabilities
    severity_mapping = {"High": 3, "Medium": 2, "Low": 1, "Informational": 0}
    
    insights = {
        "total_issues": len(alerts),
        "critical_issues": 0,
        "high_issues": 0,
        "medium_issues": 0,
        "low_issues": 0,
        "informational_issues": 0,
        "top_issues": []
    }
    
    for alert in alerts:
        severity = alert.get('risk')
        insights[f"{severity.lower()}_issues"] += 1

        # Prioritize top issues
        if severity_mapping[severity] >= 2:  # High or Medium severity
            insights["top_issues"].append({
                "alert": alert.get('alert'),
                "description": alert.get('description'),
                "risk": alert.get('risk'),
                "url": alert.get('url'),
            })
    
    # Example of more complex AI analysis (e.g., severity prediction or classification)
    # Here you could use a machine learning model to further analyze or predict risks
    # For now, it's a simple rule-based logic
    
    return insights

# Main entry point to run the Flask app
if __name__ == '__main__':
    app.run(debug=True)
