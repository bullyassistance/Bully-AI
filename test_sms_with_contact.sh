#!/bin/bash

# GHL SMS API Test Script with Contact ID
# This script tests the GoHighLevel API to send SMS using contact ID

# GHL API Configuration
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
BASE_URL="https://rest.gohighlevel.com"
VERSION="2021-07-28"

echo "Testing GoHighLevel SMS API with Contact ID..."
echo "API Key: ${API_KEY:0:20}..."
echo "Base URL: $BASE_URL"
echo "Version: $VERSION"
echo ""

# First, get a contact ID
echo "Getting contact ID..."
CONTACT_RESPONSE=$(curl -s -X GET \
  "$BASE_URL/v1/contacts/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json")

CONTACT_ID=$(echo "$CONTACT_RESPONSE" | jq -r '.contacts[0].id' 2>/dev/null)

if [ "$CONTACT_ID" = "null" ] || [ -z "$CONTACT_ID" ]; then
    echo "No contacts found. Creating a test contact first..."
    
    # Create a test contact
    CONTACT_DATA='{
      "name": "SMS Test User",
      "email": "smstest@example.com",
      "phone": "+1234567890",
      "tags": ["test"],
      "source": "SMS Test"
    }'
    
    CONTACT_CREATE_RESPONSE=$(curl -s -X POST \
      "$BASE_URL/v1/contacts/" \
      -H "Authorization: Bearer $API_KEY" \
      -H "Version: $VERSION" \
      -H "Accept: application/json" \
      -H "Content-Type: application/json" \
      -d "$CONTACT_DATA")
    
    CONTACT_ID=$(echo "$CONTACT_CREATE_RESPONSE" | jq -r '.contact.id' 2>/dev/null)
    echo "Created contact with ID: $CONTACT_ID"
else
    echo "Using existing contact ID: $CONTACT_ID"
fi

if [ "$CONTACT_ID" = "null" ] || [ -z "$CONTACT_ID" ]; then
    echo "Failed to get/create contact. Exiting."
    exit 1
fi

echo ""
echo "Testing SMS with contact ID: $CONTACT_ID"
echo ""

# Test SMS with contact ID
SMS_DATA='{
  "contactId": "'$CONTACT_ID'",
  "message": "👋 Hey there, welcome to Bully AI! Great news—your credit reports have been scanned and your dispute letters are ready. 🚀 Next step: go to OnlineCertifiedMail.com and send your letters today. You just took the first step most people never do. Keep going—you are on your way to real credit justice."
}'

echo "SMS data to send:"
echo "$SMS_DATA" | jq '.' 2>/dev/null || echo "$SMS_DATA"
echo ""

# Test different SMS endpoints with contact ID
echo "Testing SMS endpoint 1: /v1/conversations/messages/"
curl -X POST \
  "$BASE_URL/v1/conversations/messages/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$SMS_DATA" \
  -w "\n\nHTTP Status: %{http_code}\nTotal Time: %{time_total}s\n" \
  -v

echo ""
echo "=========================================="
echo ""

echo "Testing SMS endpoint 2: /v1/conversations/sms/"
curl -X POST \
  "$BASE_URL/v1/conversations/sms/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$SMS_DATA" \
  -w "\n\nHTTP Status: %{http_code}\nTotal Time: %{time_total}s\n" \
  -v

echo ""
echo "=========================================="
echo ""

echo "Testing SMS endpoint 3: /v1/messages/"
curl -X POST \
  "$BASE_URL/v1/messages/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d "$SMS_DATA" \
  -w "\n\nHTTP Status: %{http_code}\nTotal Time: %{time_total}s\n" \
  -v

echo ""
echo "Test completed!"
