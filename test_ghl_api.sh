#!/bin/bash

# GHL API Test Script
# This script tests the GoHighLevel API to create a contact

# GHL API Configuration
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
BASE_URL="https://rest.gohighlevel.com"
VERSION="2021-07-28"

echo "Testing GoHighLevel API..."
echo "API Key: ${API_KEY:0:20}..."
echo "Base URL: $BASE_URL"
echo "Version: $VERSION"
echo ""

# Test contact data
CONTACT_DATA='{
  "name": "Test User",
  "email": "test@example.com",
  "phone": "+1234567890",
  "tags": ["FREE AI"],
  "source": "Bully AI - Credit Assistant",
  "sourceId": "bully-ai-credit-assistant",
  "address": "123 Test Street, Test City, TC 12345",
  "customFields": {
    "Lead Source": "Bully AI Website",
    "Service Interest": "Credit Dispute Letters",
    "Form Submission Date": "'$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")'",
    "Welcome Message": "👋 Hey Test, welcome to Bully AI!\nGreat news—your credit reports have been scanned and your dispute letters are ready. 🚀\n\n👉 Inside your file you'\''ll see the specific errors we found on your reports. Each one could mean deletions or even compensation if not corrected.\n\n📬 Next step: go to OnlineCertifiedMail.com and send your letters today. Certified mail gives you proof the bureaus received them—this is your evidence trail.\n\nYou just took the first step most people never do. Keep going—you'\''re on your way to real credit justice."
  }
}'

echo "Contact data to send:"
echo "$CONTACT_DATA" | jq '.' 2>/dev/null || echo "$CONTACT_DATA"
echo ""

# Make the API request
echo "Making API request..."
curl -X POST \
  "$BASE_URL/v1/contacts/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$CONTACT_DATA" \
  -w "\n\nHTTP Status: %{http_code}\nTotal Time: %{time_total}s\n" \
  -v

echo ""
echo "Test completed!"
