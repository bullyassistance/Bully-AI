#!/bin/bash

# Fresh GHL Contact Creation Test
# This creates a completely new contact with your Gmail

# GHL API Configuration
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
BASE_URL="https://rest.gohighlevel.com"
VERSION="2021-07-28"

echo "=== CREATING FRESH CONTACT IN GHL ==="
echo "API Key: ${API_KEY:0:20}..."
echo "Base URL: $BASE_URL"
echo "Version: $VERSION"
echo ""

# Generate unique timestamp and random number
TIMESTAMP=$(date +%s)
RANDOM_NUM=$((RANDOM % 1000))

# Fresh contact data
CONTACT_DATA='{
  "name": "Fresh Test User '${RANDOM_NUM}'",
  "email": "muhammadmueenarif786@gmail.com",
  "phone": "+1234567890",
  "tags": ["free ai"],
  "source": "Bully AI - Credit Assistant",
  "sourceId": "bully-ai-credit-assistant",
  "address": "123 Fresh Test Street, Test City, TC 12345",
  "customFields": {
    "Lead Source": "Bully AI Website - Fresh Test",
    "Service Interest": "Credit Dispute Letters",
    "Form Submission Date": "'$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")'",
    "Test Type": "Fresh Contact Creation",
    "Welcome Message": "👋 Hey Fresh Test User, welcome to Bully AI!\nGreat news—your credit reports have been scanned and your dispute letters are ready. 🚀\n\n👉 Inside your file you will see the specific errors we found on your reports. Each one could mean deletions or even compensation if not corrected.\n\n📬 Next step: go to OnlineCertifiedMail.com and send your letters today. Certified mail gives you proof the bureaus received them—this is your evidence trail.\n\nYou just took the first step most people never do. Keep going—you are on your way to real credit justice."
  }
}'

echo "Contact data being sent:"
echo "$CONTACT_DATA" | jq '.' 2>/dev/null || echo "$CONTACT_DATA"
echo ""

echo "🚀 Sending request to GHL API..."

# Make the API request
RESPONSE=$(curl -s -w "\n\n=== RESPONSE DETAILS ===\nHTTP Status: %{http_code}\nTotal Time: %{time_total}s\n" \
  -X POST \
  "${BASE_URL}/v1/contacts/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$CONTACT_DATA")

echo "$RESPONSE"

echo ""
echo "✅ Contact creation request completed!"
echo ""
echo "📋 WHAT TO CHECK IN GHL:"
echo "1. Go to your GHL contacts list"
echo "2. Look for 'Fresh Test User ${RANDOM_NUM}'"
echo "3. Check if email is: muhammadmueenarif786@gmail.com"
echo "4. Verify tag is: 'free ai'"
echo "5. Check if workflow triggered (if configured)"
echo ""
