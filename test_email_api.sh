#!/bin/bash

# GHL Email API Test Script
# This script tests the GoHighLevel API to send emails

# GHL API Configuration
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
BASE_URL="https://rest.gohighlevel.com"
VERSION="2021-07-28"

echo "Testing GoHighLevel Email API..."
echo "API Key: ${API_KEY:0:20}..."
echo "Base URL: $BASE_URL"
echo "Version: $VERSION"
echo ""

# Test email data
EMAIL_DATA='{
  "to": "muhammadmueenarif786@gmail.com",
  "subject": "Welcome to Bully AI!",
  "htmlBody": "👋 Hey Test, welcome to Bully AI!<br><br>Great news—your credit reports have been scanned and your dispute letters are ready. 🚀<br><br>👉 Inside your file you will see the specific errors we found on your reports. Each one could mean deletions or even compensation if not corrected.<br><br>📬 Next step: go to OnlineCertifiedMail.com and send your letters today. Certified mail gives you proof the bureaus received them—this is your evidence trail.<br><br>You just took the first step most people never do. Keep going—you are on your way to real credit justice.",
  "textBody": "👋 Hey Test, welcome to Bully AI!\n\nGreat news—your credit reports have been scanned and your dispute letters are ready. 🚀\n\n👉 Inside your file you will see the specific errors we found on your reports. Each one could mean deletions or even compensation if not corrected.\n\n📬 Next step: go to OnlineCertifiedMail.com and send your letters today. Certified mail gives you proof the bureaus received them—this is your evidence trail.\n\nYou just took the first step most people never do. Keep going—you are on your way to real credit justice."
}'

echo "Email data to send:"
echo "$EMAIL_DATA" | jq '.' 2>/dev/null || echo "$EMAIL_DATA"
echo ""

# Test email endpoint
echo "Testing Email endpoint: /v1/emails/"
curl -X POST \
  "$BASE_URL/v1/emails/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$EMAIL_DATA" \
  -w "\n\nHTTP Status: %{http_code}\nTotal Time: %{time_total}s\n" \
  -v

echo ""
echo "Test completed!"
