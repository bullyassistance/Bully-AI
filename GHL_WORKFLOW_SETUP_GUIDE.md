# 🚀 GoHighLevel Workflow Setup Guide for Bully AI

## 📋 Overview
This guide will help you set up the complete nurture workflow in GoHighLevel for Bully AI users who upload their credit reports.

## ✅ What's Already Implemented
- ✅ Contact creation/update in GHL
- ✅ Tag application: "AI-Scanner-Uploaded"
- ✅ Custom fields mapping:
  - Violation Count (number of issues found)
  - Claim Value (estimated case value range)
  - Report Date (date of analysis)
  - Lead Source, Service Interest, etc.

## 🛠️ Step 1: Create Custom Fields in GHL

### Navigate to Custom Fields
1. Go to GoHighLevel Dashboard
2. Settings → Custom Fields → + Add Field

### Create These Fields:
1. **Violation Count**
   - Type: Number
   - Field Name: "Violation Count"
   - Description: "Number of violations found in credit report"

2. **Claim Value**
   - Type: Text
   - Field Name: "Claim Value"
   - Description: "Estimated case value range (e.g., 1000-5000)"

3. **Report Date**
   - Type: Date
   - Field Name: "Report Date"
   - Description: "Date when credit report was analyzed"

## 🛠️ Step 2: Create Nurture Workflow

### Navigate to Workflows
1. Go to Automations → Workflows → + New Workflow
2. Name: "AI Scanner Upload Nurture"

### Set Up Trigger
1. **Trigger Type**: Tag Added
2. **Tag**: "AI-Scanner-Uploaded"
3. **Save and Continue**

### Add Actions (In This Order):

#### Action 1: Send Immediate SMS
- **Action Type**: Send SMS
- **Message Template**:
```
{{contact.first_name}}, your AI scan shows {{custom_values.violation_count}} violations worth about ${{custom_values.claim_value}}. Timing is critical — take action now. Book your call 👉 {{appointment.booking_link}}
```

#### Action 2: Send Immediate Email
- **Action Type**: Send Email
- **Subject**: "{{contact.first_name}}, your report may be worth thousands"
- **Body Template**:
```
Hey {{contact.first_name}},

Our AI just scanned your report. Here's what we found:
- Potential violations: {{custom_values.violation_count}}
- Estimated claim value: ${{custom_values.claim_value}}

These violations give you leverage to delete negative items and claim damages. 
But timing matters — every day you wait gives creditors the upper hand.

👉 Take action now. Book your call here: {{appointment.booking_link}}

— Umar
The Bureau Bullies
```

#### Action 3: Wait 1 Day
- **Action Type**: Wait
- **Duration**: 1 Day

#### Action 4: Send Day 1 Follow-up SMS
- **Action Type**: Send SMS
- **Message Template**:
```
{{contact.first_name}}, don't let your credit violations expire! You have {{custom_values.violation_count}} violations worth ${{custom_values.claim_value}}. Book your call today: {{appointment.booking_link}}
```

#### Action 5: Send Day 1 Follow-up Email
- **Action Type**: Send Email
- **Subject**: "{{contact.first_name}}, your violations won't wait"
- **Body Template**:
```
{{contact.first_name}},

Every day you wait is money lost. Your {{custom_values.violation_count}} violations are worth ${{custom_values.claim_value}}.

The clock is ticking on your case. Book your call now:
{{appointment.booking_link}}

— Umar
The Bureau Bullies
```

#### Action 6: Wait 2 Days
- **Action Type**: Wait
- **Duration**: 2 Days

#### Action 7: Send Day 3 Follow-up SMS
- **Action Type**: Send SMS
- **Message Template**:
```
{{contact.first_name}}, last chance! Your ${{custom_values.claim_value}} case expires soon. Book now: {{appointment.booking_link}}
```

#### Action 8: Send Day 3 Follow-up Email
- **Action Type**: Send Email
- **Subject**: "Final notice: {{contact.first_name}}, your case expires soon"
- **Body Template**:
```
{{contact.first_name}},

This is your final notice. Your {{custom_values.violation_count}} violations worth ${{custom_values.claim_value}} will expire soon.

Don't let this opportunity slip away. Book your call immediately:
{{appointment.booking_link}}

— Umar
The Bureau Bullies
```

## 🛠️ Step 3: Test the Workflow

### Test Contact Creation
1. Upload a test credit report on BullyAIAgent.com
2. Fill out the lead capture form
3. Verify in GHL:
   - Contact is created
   - Tag "AI-Scanner-Uploaded" is applied
   - Custom fields are populated:
     - Violation Count: [number]
     - Claim Value: [range]
     - Report Date: [today's date]

### Test Workflow Trigger
1. Check that the workflow is triggered immediately
2. Verify SMS and email are sent
3. Check follow-up messages are scheduled

## 🛠️ Step 4: Optional - Zapier Integration

If you want to use Zapier instead of direct API integration:

### Set Up Zapier Webhook
1. Create a new Zap
2. Trigger: Webhooks by Zapier → Catch Hook
3. Copy the webhook URL
4. Add this to the Bully AI website (replace direct GHL API call)

### Zapier Action
1. Action: LeadConnector (GoHighLevel)
2. Action: Create/Update Contact
3. Map fields:
   - Name → First Name
   - Email → Email
   - Phone → Phone
   - Violation Count → Custom Field "Violation Count"
   - Claim Value → Custom Field "Claim Value"
   - Report Date → Custom Field "Report Date"
4. Add Tag: "AI-Scanner-Uploaded"

## 📊 Monitoring and Optimization

### Track These Metrics:
- Contact creation rate
- Workflow trigger rate
- SMS/Email delivery rates
- Appointment booking rate
- Follow-up completion rate

### Optimize Based on Data:
- A/B test message templates
- Adjust timing of follow-ups
- Refine call-to-action messages
- Update custom field values

## 🔧 Troubleshooting

### Common Issues:
1. **Contacts not created**: Check API key and permissions
2. **Custom fields not populated**: Verify field names match exactly
3. **Workflow not triggered**: Check tag name matches exactly
4. **Messages not sent**: Verify SMS/Email settings and templates

### Debug Steps:
1. Check GHL API logs
2. Verify contact data in GHL
3. Test workflow manually
4. Check message delivery status

## 📞 Support
For technical issues with this integration, contact the development team with:
- Screenshots of the issue
- GHL contact ID
- Timestamp of the problem
- Browser console errors (if any)

---

**Note**: This integration is now fully functional. The website will automatically create contacts in GHL with the proper tags and custom fields when users upload their credit reports and fill out the lead capture form.
