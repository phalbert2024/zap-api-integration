const axios = require('axios');

const zapApiUrl = 'http://192.168.10.10:8080'; Replace your actual 
const apiKey = 'your_zap_api_key_here'; // Replace with your actual API key

async function startZapScan(targetUrl) {
    try {
        const response = await axios.get(`${zapApiUrl}/JSON/ascan/action/scan/?url=${targetUrl}&apikey=${apiKey}`);
        console.log('Scan started:', response.data);
    } catch (error) {
        console.error('Error starting scan:', error);
    }
}

async function getZapScanResults(scanId) {
    try {
        const response = await axios.get(`${zapApiUrl}/JSON/ascan/view/scanProgress/?scanId=${scanId}&apikey=${apiKey}`);
        console.log('Scan progress:', response.data);
    } catch (error) {
        console.error('Error getting scan results:', error);
    }
}

module.exports = { startZapScan, getZapScanResults };
