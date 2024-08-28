# Installation Guide

This document provides step-by-step instructions for setting up the ZAP API integration on your system.

## Prerequisites

- Kali Linux installed
- ZAP (Zed Attack Proxy) installed
- Node.js and npm installed
- Python installed

## Steps

1. Install the ZAP API.
2. Set up the development environment.
3. Integrate the ZAP API into the project.
## Configure ZAP API

1. **Open ZAP GUI:**
   - Launch ZAP and navigate to `Tools > Options > API`.

2. **Enable the API:**
   - Check the option **Enable the API** to allow external applications to interact with ZAP.

3. **Note API Details:**
   - If required, note down the **API key**.
   - The **API address/port** is usually `http://localhost:8080` by default.

## Verify ZAP Installation

1. **Check ZAP is Running:**
   - Open your web browser and navigate to `http://localhost:8080/JSON/core/view/version/`.

2. **Confirm Version Information:**
   - If everything is configured correctly, the version information of ZAP should be displayed.
