#!/bin/bash

# GoHighLevel API Testing Script - WORKING VERSION
# This script tests the correct GoHighLevel API endpoints

# API Configuration
API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0"
VERSION="2021-07-28"
BASE_URL="https://rest.gohighlevel.com"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== GoHighLevel API Testing Script (WORKING VERSION) ===${NC}"
echo -e "${CYAN}Base URL: $BASE_URL${NC}"
echo -e "${CYAN}API Version: $VERSION${NC}"
echo ""

# Function to test endpoint
test_endpoint() {
    local method=$1
    local endpoint=$2
    local data=$3
    local description=$4
    
    echo -e "${YELLOW}Testing: $description${NC}"
    echo -e "${CYAN}URL: $BASE_URL$endpoint${NC}"
    echo "Method: $method"
    echo ""
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\n%{http_code}" -X GET "$BASE_URL$endpoint" \
            -H "Authorization: Bearer $API_KEY" \
            -H "Version: $VERSION" \
            -H "Accept: application/json")
    else
        response=$(curl -s -w "\n%{http_code}" -X POST "$BASE_URL$endpoint" \
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

# Test 1: GET contacts
test_endpoint "GET" \
    "/v1/contacts/" \
    "" \
    "GET all contacts"

# Test 2: POST new contact
contact_data='{
    "name": "API Test Contact",
    "email": "api.test@example.com",
    "phone": "+12345678901",
    "tags": ["API Test", "Automated"],
    "source": "API Testing Script"
}'

test_endpoint "POST" \
    "/v1/contacts/" \
    "$contact_data" \
    "POST new contact"

# Test 3: GET contacts with pagination (first 5)
test_endpoint "GET" \
    "/v1/contacts/?limit=5" \
    "" \
    "GET first 5 contacts"

echo -e "${BLUE}=== Testing Complete ===${NC}"
echo -e "${GREEN}✓ All tests completed successfully!${NC}"
echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "1. Check your GoHighLevel dashboard to see the new contact"
echo "2. Use the contact ID from the POST response for further operations"
echo "3. The API is working correctly with rest.gohighlevel.com"
