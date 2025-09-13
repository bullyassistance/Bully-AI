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
        const response = await fetch(`${GHL_CONFIG.baseUrl}/v1/contacts/`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${GHL_CONFIG.apiKey}`,
                'Version': GHL_CONFIG.version,
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: contactData.name,
                email: contactData.email,
                phone: contactData.phone,
                tags: [GHL_CONFIG.contactListName],
                source: 'Bully AI - Credit Assistant',
                address: contactData.address,
                customFields: {
                    'Lead Source': 'Bully AI Website',
                    'Service Interest': 'Credit Dispute Letters',
                    'Form Submission Date': new Date().toISOString()
                }
            })
        });

        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`GHL API Error: ${response.status} - ${errorText}`);
        }

        const result = await response.json();
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
 * Handle form submission with GHL integration
 * @param {Object} userData - Form data from the lead capture form
 * @param {string} formSelector - Optional form selector (defaults to #lead-capture-form)
 * @returns {Promise<boolean>} - Success status
 */
async function handleGHLFormSubmission(userData, formSelector = '#lead-capture-form') {
    // Show loading indicator
    const submitButton = document.querySelector(`${formSelector} button[type="submit"]`);
    let originalText = 'Submit';
    
    if (submitButton) {
        originalText = submitButton.textContent;
        submitButton.textContent = 'Sending...';
        submitButton.disabled = true;
    }

    try {
        // Save to GHL
        await saveContactToGHL(userData);

        // Show success message
        showSuccessMessage(userData.name);

        // Reset button if it exists
        if (submitButton) {
            submitButton.textContent = originalText;
            submitButton.disabled = false;
        }

        return true;

    } catch (error) {
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
    showErrorMessage
};
