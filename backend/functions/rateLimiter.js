/**
 * Rate Limiter Module for Firebase Cloud Functions
 * Transaction-based rate limiting with Firestore backend
 */

const { getFirestore, FieldValue } = require('firebase-admin/firestore');
const { HttpsError } = require('firebase-functions/v2/https');

// Rate limit configurations per function
const RATE_LIMITS = {
    interpretDream: { maxRequests: 20, windowMinutes: 60 },      // 20/hour
    generateDailyTip: { maxRequests: 10, windowMinutes: 60 },    // 10/hour
    analyzeDreams: { maxRequests: 5, windowMinutes: 1440 },      // 5/day
    analyzeMoonSync: { maxRequests: 5, windowMinutes: 1440 }     // 5/day
};

/**
 * Generates a unique user key from the request
 * Uses App Check token ID or falls back to IP address
 */
function getUserKey(request) {
    // Try App Check token first (most secure)
    if (request.app?.appId) {
        return `app_${request.app.appId}`;
    }

    // Fallback to IP-based key
    const ip = request.rawRequest?.ip ||
        request.rawRequest?.headers?.['x-forwarded-for']?.split(',')[0] ||
        'unknown';

    // Hash the IP for privacy (simple hash)
    let hash = 0;
    for (let i = 0; i < ip.length; i++) {
        hash = ((hash << 5) - hash) + ip.charCodeAt(i);
        hash = hash & hash; // Convert to 32bit integer
    }
    return `ip_${Math.abs(hash).toString(36)}`;
}

/**
 * Checks rate limit for a function using Firestore transactions
 * @param {string} functionName - Name of the function being called
 * @param {object} request - The Cloud Function request object
 * @returns {Promise<{allowed: boolean, resetMinutes?: number}>}
 */
async function checkRateLimit(functionName, request) {
    const config = RATE_LIMITS[functionName];
    if (!config) {
        console.warn(`No rate limit config for ${functionName}, allowing request`);
        return { allowed: true };
    }

    const db = getFirestore();
    const userKey = getUserKey(request);
    const docRef = db.collection('rateLimits').doc(`${functionName}_${userKey}`);

    const now = Date.now();
    const windowMs = config.windowMinutes * 60 * 1000;
    const windowStart = now - windowMs;

    try {
        const result = await db.runTransaction(async (transaction) => {
            const doc = await transaction.get(docRef);

            let requests = [];
            let blockedCount = 0;
            let lastBlockedAt = null;

            if (doc.exists) {
                const data = doc.data();
                // Filter to only keep requests within the active window
                requests = (data.requests || []).filter(ts => ts > windowStart);
                blockedCount = data.blockedCount || 0;
                lastBlockedAt = data.lastBlockedAt || null;
            }

            // Check if limit exceeded
            if (requests.length >= config.maxRequests) {
                // Calculate when the oldest request in window will expire
                const oldestRequest = Math.min(...requests);
                const resetTime = oldestRequest + windowMs;
                const resetMinutes = Math.ceil((resetTime - now) / 60000);

                // Update blocked tracking
                transaction.set(docRef, {
                    requests: requests, // Keep cleaned array
                    blockedCount: blockedCount + 1,
                    lastBlockedAt: now,
                    lastAttempt: now
                }, { merge: true });

                return { allowed: false, resetMinutes: Math.max(1, resetMinutes) };
            }

            // Add new request timestamp
            requests.push(now);

            transaction.set(docRef, {
                requests: requests,
                blockedCount: blockedCount,
                lastBlockedAt: lastBlockedAt,
                lastRequest: now
            });

            return { allowed: true };
        });

        return result;
    } catch (error) {
        console.error('Rate limit check error:', error);
        // On error, allow the request but log it
        return { allowed: true };
    }
}

/**
 * Middleware function to enforce rate limiting
 * Throws HttpsError if rate limit exceeded
 */
async function enforceRateLimit(functionName, request) {
    const result = await checkRateLimit(functionName, request);

    if (!result.allowed) {
        throw new HttpsError(
            'resource-exhausted',
            `Rate limit exceeded. Try again in ${result.resetMinutes} minute(s).`,
            { resetMinutes: result.resetMinutes }
        );
    }
}

module.exports = {
    checkRateLimit,
    enforceRateLimit,
    RATE_LIMITS,
    getUserKey
};
