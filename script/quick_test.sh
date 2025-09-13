#!/bin/bash

# Quick GoHighLevel API Test
# Simple one-liner tests for quick verification

API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"

echo "🔍 Quick GoHighLevel API Test"
echo "=============================="
echo ""

echo "1. Testing GET contacts (first 3)..."
curl -s "https://rest.gohighlevel.com/v1/contacts/?limit=3" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: 2021-07-28" \
  -H "Accept: application/json" | jq '.contacts[] | {id, contactName, email, phone}'

echo ""
echo "2. Testing POST new contact..."
curl -s -X POST "https://rest.gohighlevel.com/v1/contacts/" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Version: 2021-07-28" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Quick Test Contact",
    "email": "quick.test@example.com",
    "phone": "+12345678999",
    "tags": ["Quick Test"],
    "source": "Quick Test Script"
  }' | jq '.contact | {id, contactName, email, phone, tags}'

echo ""
echo "✅ Quick test completed!"
