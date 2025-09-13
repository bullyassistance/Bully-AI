#!/bin/bash

# GoHighLevel API Testing Script
# This script tests various endpoints and configurations

# API Configuration
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
VERSION="2021-07-28"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== GoHighLevel API Testing Script ===${NC}"
echo ""

# Function to test endpoint
test_endpoint() {
    local method=$1
    local url=$2
    local data=$3
    local description=$4
    
    echo -e "${YELLOW}Testing: $description${NC}"
    echo "URL: $url"
    echo "Method: $method"
    echo ""
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\n%{http_code}" -X GET "$url" \
            -H "Authorization: Bearer $API_KEY" \
            -H "Version: $VERSION" \
            -H "Accept: application/json")
    else
        response=$(curl -s -w "\n%{http_code}" -X POST "$url" \
            -H "Authorization: Bearer $API_KEY" \
            -H "Version: $VERSION" \
            -H "Accept: application/json" \
            -H "Content-Type: application/json" \
            -d "$data")
    fi
    
    # Split response and status code
    http_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | sed '$d')
    
    echo "HTTP Status: $http_code"
    
    if [ "$http_code" -eq 200 ] || [ "$http_code" -eq 201 ]; then
        echo -e "${GREEN}✓ SUCCESS${NC}"
        if [ -n "$body" ]; then
            echo "Response Body:"
            echo "$body" | jq . 2>/dev/null || echo "$body"
        fi
    else
        echo -e "${RED}✗ FAILED${NC}"
        echo "Error Response:"
        echo "$body"
    fi
    
    echo ""
    echo "----------------------------------------"
    echo ""
}

# Test 1: GET contacts from services.leadconnectorhq.com/v1/contacts
test_endpoint "GET" \
    "https://services.leadconnectorhq.com/v1/contacts" \
    "" \
    "GET contacts from /v1/contacts endpoint"

# Test 2: GET contacts from services.leadconnectorhq.com/contacts/
test_endpoint "GET" \
    "https://services.leadconnectorhq.com/contacts/" \
    "" \
    "GET contacts from /contacts/ endpoint"

# Test 3: GET contacts from api.leadconnectorhq.com/contacts/
test_endpoint "GET" \
    "https://api.leadconnectorhq.com/contacts/" \
    "" \
    "GET contacts from api.leadconnectorhq.com/contacts/"

# Test 4: POST contact to services.leadconnectorhq.com/v1/contacts
contact_data='{
    "name": "Test Contact",
    "email": "test.contact@youremail.com",
    "phone": "+12345678900",
    "tags": ["FREE AI"],
    "source": "cURL API Test"
}'

test_endpoint "POST" \
    "https://services.leadconnectorhq.com/v1/contacts" \
    "$contact_data" \
    "POST contact to /v1/contacts endpoint"

# Test 5: POST contact to services.leadconnectorhq.com/contacts/
test_endpoint "POST" \
    "https://services.leadconnectorhq.com/contacts/" \
    "$contact_data" \
    "POST contact to /contacts/ endpoint"

# Test 6: POST contact to api.leadconnectorhq.com/contacts/
test_endpoint "POST" \
    "https://api.leadconnectorhq.com/contacts/" \
    "$contact_data" \
    "POST contact to api.leadconnectorhq.com/contacts/"

echo -e "${BLUE}=== Testing Complete ===${NC}"
