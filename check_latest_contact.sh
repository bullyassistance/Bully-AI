#!/bin/bash

# Check the latest contact created in GHL
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
BASE_URL="https://rest.gohighlevel.com"
VERSION="2021-07-28"

echo "Checking latest contact in GHL..."
echo ""

# Get the latest contact (should be the one we just created)
curl -X GET \
  "$BASE_URL/v1/contacts/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -w "\n\nHTTP Status: %{http_code}\n" \
  | jq '.contacts[0] | {id, name, email, tags, source, customFields}' 2>/dev/null || echo "No jq available, showing raw response"

echo ""
echo "Check completed!"
