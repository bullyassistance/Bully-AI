#!/bin/bash

# Delete the existing contact to test fresh
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
BASE_URL="https://rest.gohighlevel.com"
VERSION="2021-07-28"
CONTACT_ID="AoM6K3mfkplwcFjucOQr"  # The contact ID from the response

echo "Deleting contact with ID: $CONTACT_ID"
echo ""

curl -X DELETE \
  "$BASE_URL/v1/contacts/$CONTACT_ID" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: $VERSION" \
  -H "Accept: application/json" \
  -w "\n\nHTTP Status: %{http_code}\n"

echo ""
echo "Contact deletion completed!"
