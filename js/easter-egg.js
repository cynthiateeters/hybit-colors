/**
 * HAP's Learning Lab - HyBit Insights Easter Egg
 *
 * Displays educational insights when ?hybit parameter is present in URL
 * Content is loaded from data/hybit-insights.json for easy maintenance
 *
 * Security: Uses whitelist validation and pre-defined messages only.
 * Never uses user input directly in innerHTML to prevent XSS attacks.
 */

document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    const hybitParam = urlParams.get('hybit');

    // Only activate if hybit parameter exists
    if (hybitParam !== null) {
        // Determine base path - go up one level from stations/ to reach data/
        const basePath = window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/') + 1);
        const jsonPath = basePath + '../data/hybit-insights.json';

        // Load insights data from JSON
        fetch(jsonPath)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to load insights data');
                }
                return response.json();
            })
            .then(data => {
                initializeEasterEgg(data, hybitParam);
            })
            .catch(error => {
                console.error('HyBit Insights error:', error);
                // Fallback to basic message if JSON fails to load
                showFallbackMessage();
            });
    }
});

/**
 * Initialize and display the easter egg with loaded data
 */
function initializeEasterEgg(data, hybitParam) {
    const avatar = document.querySelector('.hybit-avatar');
    if (!avatar) return; // Exit if avatar not found

    const avatarContainer = avatar.parentElement;
    if (!avatarContainer) return; // Exit if container not found

    // Add animation class
    avatar.classList.add('hybit-mode');

    // Display dialog after 2 second delay (after spin animation)
    setTimeout(() => {
        const messageContent = getMessageContent(data, hybitParam);
        showDialog(messageContent);
    }, 2000);
}

/**
 * Determine which message to display based on parameter and page
 */
function getMessageContent(data, hybitParam) {
    const currentPage = window.location.pathname.split('/').pop();

    if (hybitParam === '') {
        // Empty parameter - show page-specific help
        return getPageHelpMessage(data, currentPage);
    } else if (data.allowedParams.includes(hybitParam)) {
        // Valid parameter - show specific insight message
        return getInsightMessage(data, hybitParam);
    } else {
        // Invalid parameter - show generic discovery message
        return getUnknownMessage(data);
    }
}

/**
 * Build page-specific help message with suggestions
 */
function getPageHelpMessage(data, currentPage) {
    const pageData = data.pageHelp[currentPage];

    if (!pageData) {
        // Fallback for unknown pages
        return `<h3>${data.defaults.emptyFallback.title}</h3><p>${data.defaults.emptyFallback.content}</p>`;
    }

    let html = `<h3>${pageData.title}</h3>`;

    if (pageData.intro) {
        html += `<p>${pageData.intro}</p>`;
    }

    if (pageData.suggestions && pageData.suggestions.length > 0) {
        html += '<ul>';
        pageData.suggestions.forEach(suggestion => {
            html += `<li><code>?hybit=${suggestion.param}</code> - ${suggestion.label}</li>`;
        });
        html += '</ul>';
    }

    return html;
}

/**
 * Build specific insight message
 */
function getInsightMessage(data, param) {
    const message = data.messages[param];
    return `<h3>${message.title}</h3><p>${message.content}</p>`;
}

/**
 * Build unknown parameter message
 */
function getUnknownMessage(data) {
    const message = data.defaults.unknown;
    return `<h3>${message.title}</h3><p>${message.content}</p>`;
}

/**
 * Create and display the modal dialog
 */
function showDialog(messageContent) {
    // Create dialog element
    const dialog = document.createElement('dialog');
    dialog.className = 'hybit-insight-dialog';
    dialog.innerHTML = `
        <div class="dialog-header">
            <div class="hybit-badge">
                <img src="https://res.cloudinary.com/cynthia-teeters/image/upload/f_auto,q_auto,w_80,c_limit/v1759495998/hap-laptop_xiewar.jpg"
                     alt="HAP (HyBit A. ProtoBot)"
                     width="80"
                     height="80">
            </div>
            <button class="dialog-close" aria-label="Close">×</button>
        </div>
        <div class="dialog-content">
            ${messageContent}
        </div>
    `;

    // Append dialog to body
    document.body.appendChild(dialog);

    // Show modal dialog
    dialog.showModal();

    // Close on backdrop click
    dialog.addEventListener('click', (e) => {
        if (e.target === dialog) {
            dialog.close();
        }
    });

    // Close button handler
    dialog.querySelector('.dialog-close').addEventListener('click', () => {
        dialog.close();
    });

    // Remove dialog from DOM when closed
    dialog.addEventListener('close', () => {
        setTimeout(() => dialog.remove(), 300);
    });
}

/**
 * Fallback message if JSON fails to load
 */
function showFallbackMessage() {
    const avatar = document.querySelector('.hybit-avatar');
    if (!avatar) return;

    avatar.classList.add('hybit-mode');

    setTimeout(() => {
        const fallbackContent = '<h3>🎯 HAP\'s Insights</h3><p>Oops! I couldn\'t load my insights right now. Prof. Teeters says this might be a network issue. Please try again later!</p>';
        showDialog(fallbackContent);
    }, 2000);
}
