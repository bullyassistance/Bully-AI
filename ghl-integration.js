/**
 * GoHighLevel API Integration
 * Handles saving user data to GHL contacts with "FREE AI" tag
 */

// GHL API Configuration
const GHL_CONFIG = {
    baseUrl: 'https://rest.gohighlevel.com',
    apiKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2NhdGlvbl9pZCI6Im1lWDBFcnk0YUJXdGpHME1HMFR1IiwidmVyc2lvbiI6MSwiaWF0IjoxNzU3NzQ1OTc5NjcyLCJzdWIiOiJNNThpeGpnSWdtb2doRXBYNVJ1ViJ9.kBGx9-dPuTraGnga-WG-_CMmjE1DCthkYjRCmbEGus0',
    version: '2021-07-28',
    contactListName: 'FREE AI'
};

/**
 * Save contact to GoHighLevel
 * @param {Object} contactData - User contact information
 * @returns {Promise<Object>} - API response
 */
async function saveContactToGHL(contactData) {
    try {
        // Format phone number to ensure it's saved exactly as entered
        let formattedPhone = contactData.phone;
        // Remove any existing country code if it starts with +1
        if (formattedPhone.startsWith('+1')) {
            formattedPhone = formattedPhone.substring(2);
        }
        // Ensure it doesn't start with + unless user specifically entered it
        if (!formattedPhone.startsWith('+') && !formattedPhone.startsWith('1')) {
            // Keep the phone number exactly as entered by user
            formattedPhone = contactData.phone;
        }
        
        const contactPayload = {
            name: contactData.name,
            email: contactData.email, // Use original email exactly as entered
            phone: formattedPhone, // Use formatted phone number
            tags: [GHL_CONFIG.contactListName.toLowerCase()],
            source: 'Bully AI - Credit Assistant',
            sourceId: 'bully-ai-credit-assistant',
            address: contactData.address,
            customFields: {
                'Lead Source': 'Bully AI Website',
                'Service Interest': 'Credit Dispute Letters',
                'Form Submission Date': new Date().toISOString(),
                'Welcome Message': `👋 Hey ${contactData.name.split(' ')[0] || 'there'}, welcome to Bully AI!
Great news—your credit reports have been scanned and your dispute letters are ready. 🚀

👉 Inside your file you'll see the specific errors we found on your reports. Each one could mean deletions or even compensation if not corrected.

📬 Next step: go to OnlineCertifiedMail.com and send your letters today. Certified mail gives you proof the bureaus received them—this is your evidence trail.

You just took the first step most people never do. Keep going—you're on your way to real credit justice.`
            }
        };

        console.log('Sending contact to GHL...');
        console.log('Contact name:', contactPayload.name);
        console.log('Contact email:', contactPayload.email);
        console.log('Contact phone:', contactPayload.phone);

        const response = await fetch(`${GHL_CONFIG.baseUrl}/v1/contacts/`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${GHL_CONFIG.apiKey}`,
                'Version': GHL_CONFIG.version,
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(contactPayload)
        });

        if (!response.ok) {
            const errorText = await response.text();
            console.error('GHL API Error Response:', response.status, errorText);
            throw new Error(`GHL API Error: ${response.status} - ${errorText}`);
        }

        const result = await response.json();
        console.log('GHL API Success - Contact created with ID:', result.contact?.id);
        return result;

    } catch (error) {
        console.error('Error saving contact to GHL:', error);
        throw error;
    }
}

/**
 * Show success message to user
 * @param {string} contactName - Name of the contact that was saved
 */
function showSuccessMessage(contactName) {
    // Create success message element
    const successDiv = document.createElement('div');
    successDiv.id = 'ghl-success-message';
    successDiv.className = 'fixed top-4 right-4 bg-green-500 text-white px-6 py-4 rounded-lg shadow-lg z-50 flex items-center space-x-3';
    successDiv.innerHTML = `
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
        </svg>
        <div>
            <p class="font-semibold">Request Submitted!</p>
            <p class="text-sm opacity-90">We'll contact you shortly</p>
        </div>
    `;

    // Add to page
    document.body.appendChild(successDiv);

    // Auto-remove after 5 seconds
    setTimeout(() => {
        if (successDiv.parentNode) {
            successDiv.parentNode.removeChild(successDiv);
        }
    }, 5000);

    // Add click to close
    successDiv.addEventListener('click', () => {
        if (successDiv.parentNode) {
            successDiv.parentNode.removeChild(successDiv);
        }
    });
}

/**
 * Show error message to user
 * @param {string} errorMessage - Error message to display
 */
function showErrorMessage(errorMessage) {
    // Create error message element
    const errorDiv = document.createElement('div');
    errorDiv.id = 'ghl-error-message';
    errorDiv.className = 'fixed top-4 right-4 bg-red-500 text-white px-6 py-4 rounded-lg shadow-lg z-50 flex items-center space-x-3';
    errorDiv.innerHTML = `
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
        </svg>
        <div>
            <p class="font-semibold">Error Saving Contact</p>
            <p class="text-sm opacity-90">${errorMessage}</p>
        </div>
    `;

    // Add to page
    document.body.appendChild(errorDiv);

    // Auto-remove after 7 seconds
    setTimeout(() => {
        if (errorDiv.parentNode) {
            errorDiv.parentNode.removeChild(errorDiv);
        }
    }, 7000);

    // Add click to close
    errorDiv.addEventListener('click', () => {
        if (errorDiv.parentNode) {
            errorDiv.parentNode.removeChild(errorDiv);
        }
    });
}

/**
 * Send email via GoHighLevel API
 * @param {string} toEmail - Recipient email address
 * @param {string} subject - Email subject
 * @param {string} message - Email message content
 * @returns {Promise<boolean>} - Success status
 */
async function sendEmail(toEmail, subject, message) {
    try {
        console.log('Sending email via GHL API...');
        console.log('To:', toEmail);
        console.log('Subject:', subject);
        
        const emailPayload = {
            to: toEmail,
            subject: subject,
            htmlBody: message.replace(/\n/g, '<br>'),
            textBody: message
        };

        const response = await fetch(`${GHL_CONFIG.baseUrl}/v1/emails/`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${GHL_CONFIG.apiKey}`,
                'Version': GHL_CONFIG.version,
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(emailPayload)
        });

        if (!response.ok) {
            const errorText = await response.text();
            console.error('GHL Email API Error Response:', response.status, errorText);
            throw new Error(`GHL Email API Error: ${response.status} - ${errorText}`);
        }

        const result = await response.json();
        console.log('GHL Email API Success Response:', result);
        return true;

    } catch (error) {
        console.error('Error sending email via GHL API:', error);
        // Fallback: just log the message for manual sending
        console.log('Email fallback - message for manual sending:');
        console.log('To:', toEmail);
        console.log('Subject:', subject);
        console.log('Message:', message);
        return false;
    }
}

/**
 * Handle form submission with GHL integration
 * @param {Object} userData - Form data from the lead capture form
 * @param {string} formSelector - Optional form selector (defaults to #lead-capture-form)
 * @returns {Promise<boolean>} - Success status
 */
async function handleGHLFormSubmission(userData, formSelector = '#lead-capture-form') {
    console.log('handleGHLFormSubmission called with:', userData);
    
    // Show loading indicator
    const submitButton = document.querySelector(`${formSelector} button[type="submit"]`);
    let originalText = 'Submit';
    
    if (submitButton) {
        originalText = submitButton.textContent;
        submitButton.textContent = 'Sending...';
        submitButton.disabled = true;
    }

    try {
        console.log('About to call saveContactToGHL...');
        // Save to GHL
        const result = await saveContactToGHL(userData);
        console.log('saveContactToGHL result:', result);

        // Show success message
        showSuccessMessage(userData.name);

        // Reset button if it exists
        if (submitButton) {
            submitButton.textContent = originalText;
            submitButton.disabled = false;
        }

        console.log('GHL integration completed successfully');
        return true;

    } catch (error) {
        console.error('Error in handleGHLFormSubmission:', error);
        // Show error message
        showErrorMessage(error.message || 'Failed to save contact. Please try again.');

        // Reset button if it exists
        if (submitButton) {
            submitButton.textContent = originalText;
            submitButton.disabled = false;
        }

        return false;
    }
}

// Export functions for use in other scripts
window.GHLIntegration = {
    saveContactToGHL,
    handleGHLFormSubmission,
    showSuccessMessage,
    showErrorMessage,
    sendEmail
};
