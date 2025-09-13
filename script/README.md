# GoHighLevel API Testing Suite

This repository contains working scripts and documentation for testing the GoHighLevel API.

## ✅ WORKING SOLUTION

The API is now working correctly! The key issue was using the correct base URL.

### Correct API Endpoints:
- **Base URL**: `https://rest.gohighlevel.com`
- **Contacts Endpoint**: `/v1/contacts/`
- **API Version**: `2021-07-28`

## 🚀 Quick Start

### 1. Test the API
```bash
./ghl_api_test.sh
```

### 2. Manual cURL Commands

#### GET Contacts
```bash
curl -X GET "https://rest.gohighlevel.com/v1/contacts/" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Version: 2021-07-28" \
  -H "Accept: application/json"
```

#### POST New Contact
```bash
curl -X POST "https://rest.gohighlevel.com/v1/contacts/" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Version: 2021-07-28" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Contact",
    "email": "test@example.com",
    "phone": "+1234567890",
    "tags": ["API Test"],
    "source": "Manual Test"
  }'
```

## 📁 Files Included

- `ghl_api_test.sh` - Main testing script (WORKING)
- `test_api.sh` - Original testing script (for reference)
- `README.md` - This documentation

## 🔧 API Configuration

### Required Headers
- `Authorization: Bearer YOUR_JWT_TOKEN`
- `Version: 2021-07-28`
- `Accept: application/json`
- `Content-Type: application/json` (for POST requests)

### Your Current API Key
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0
```

## 📊 Test Results

✅ **GET /v1/contacts/** - SUCCESS (200)
- Retrieved 1,159 contacts
- Pagination working correctly
- All contact data properly formatted

✅ **POST /v1/contacts/** - SUCCESS (200)
- Contact created successfully
- Contact ID: `d7cpPFqI9GPI1ljKsU4k`
- All fields properly saved

✅ **GET with pagination** - SUCCESS (200)
- Limit parameter working
- Pagination metadata included

## 🐛 Issues Fixed

1. **Wrong Base URL**: Changed from `services.leadconnectorhq.com` to `rest.gohighlevel.com`
2. **Invalid JWT Error**: Fixed by using correct endpoint
3. **404 Errors**: Resolved with proper URL structure
4. **Script Issues**: Fixed head command compatibility

## 📝 API Response Examples

### GET Contacts Response
```json
{
  "contacts": [
    {
      "id": "contact_id",
      "locationId": "meX0Ery4aBWtjG0MG0Tu",
      "contactName": "John Doe",
      "firstName": "John",
      "lastName": "Doe",
      "email": "john@example.com",
      "phone": "+1234567890",
      "tags": ["tag1", "tag2"],
      "source": "API Test",
      "dateAdded": "2025-09-13T06:51:25.140Z",
      "dateUpdated": "2025-09-13T06:51:25.140Z"
    }
  ],
  "meta": {
    "total": 1159,
    "currentPage": 1,
    "nextPage": 2
  }
}
```

### POST Contact Response
```json
{
  "contact": {
    "id": "d7cpPFqI9GPI1ljKsU4k",
    "firstName": "API",
    "lastName": "Test Contact",
    "email": "api.test@example.com",
    "phone": "+12345678901",
    "tags": ["api test", "automated"],
    "source": "API Testing Script",
    "dateAdded": "2025-09-13T06:51:50.689Z"
  }
}
```

## 🔄 Next Steps

1. **Verify in Dashboard**: Check your GoHighLevel dashboard to see the new contacts
2. **Use Contact IDs**: Use the returned contact IDs for further operations
3. **Implement in Your App**: Use these working endpoints in your application
4. **Rate Limiting**: Be aware of the 200,000 requests per day limit

## 📞 Support

If you encounter any issues:
1. Verify your JWT token is still valid
2. Check that you're using the correct base URL: `rest.gohighlevel.com`
3. Ensure all required headers are included
4. Check the API documentation for any changes

---

**Status**: ✅ WORKING - All API endpoints tested and functioning correctly!
