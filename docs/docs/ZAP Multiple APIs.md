## Managing Multiple API Keys in ZAP

When working on multiple projects or with different users, managing API keys effectively is crucial. Below are the steps to handle multiple API keys in ZAP.

### 1. **Generating Multiple API Keys:**

   - **Navigate to API Options:**
     - In the ZAP GUI, go to `Tools > Options > API`.
   
   - **Generate a New API Key:**
     - ZAP does not natively support multiple API keys out of the box, but you can create different configurations with different keys by manually setting them up for different environments or instances.
     - To set a new API key, go to the `API` section, enable the API, and manually set a new key. Save this key for later use.

### 2. **Storing API Keys Securely:**

   - **Environment Variables:**
     - Store API keys in environment variables to keep them out of your source code. You can set environment variables in your operating system or within your CI/CD pipeline.
     - Example (Linux/MacOS):
       ```bash
       export ZAP_API_KEY_1="your-api-key-1"
       export ZAP_API_KEY_2="your-api-key-2"
       ```
     - Example (Windows):
       ```cmd
       set ZAP_API_KEY_1=your-api-key-1
       set ZAP_API_KEY_2=your-api-key-2
       ```

   - **Secure Vaults:**
     - Use a secrets management tool like AWS Secrets Manager, HashiCorp Vault, or Azure Key Vault to store and retrieve API keys securely.

### 3. **Using API Keys in Requests:**

   - **Making API Calls:**
     - When interacting with the ZAP API, include the relevant API key in your request. This is usually done via a query parameter.
     - Example using `curl`:
       ```bash
       curl "http://localhost:8080/JSON/core/view/version/?apikey=$ZAP_API_KEY_1"
       ```
     - Replace `$ZAP_API_KEY_1` with the appropriate environment variable or manually insert the API key.

### 4. **Rotating API Keys:**

   - **Manual Rotation:**
     - Periodically update the API key by generating a new one in the ZAP API options (`Tools > Options > API`). Replace the old key in your environment variables or secrets management tool with the new one.
   
   - **Automated Rotation:**
     - Implement scripts that automate the rotation of API keys across your infrastructure, updating environment variables, and notifying relevant stakeholders of the changes.

### 5. **Revoking and Replacing API Keys:**

   - **Revoking a Compromised Key:**
     - If an API key is compromised, go to `Tools > Options > API`, disable the API, and regenerate a new key. Update your environment and scripts with the new key immediately.
   
   - **Replacing the API Key:**
     - Follow the same steps as generating a new API key, then update your applications and configurations with the new key to ensure continued access.

### 6. **Tracking API Usage:**

   - **Logging Usage:**
     - Keep a log of which API key is associated with each project or user. This can be done manually or through an automated logging system.
     - Review logs regularly to detect any unusual activity or unauthorized access.

By following these steps, you can effectively manage multiple API keys in ZAP, ensuring both security and operational efficiency across different projects and teams.
