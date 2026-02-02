const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const { OpenAI } = require("openai");
const { enforceRateLimit } = require("./rateLimiter");

// dictionary import removed as we now use LLM knowledge for symbols

// Initialize Firebase Admin (Required for Storage/Firestore access)
admin.initializeApp();

// Güvenli API Key - Firebase Secrets ile saklanır
// Deploy öncesi: firebase functions:secrets:set OPENAI_API_KEY
const openaiApiKey = defineSecret("OPENAI_API_KEY");



const { dreamDictionary } = require("./data/dream_dictionary_new");

exports.interpretDream = onCall({ secrets: [openaiApiKey] }, async (request) => {
    // Rate limit check
    await enforceRateLimit('interpretDream', request);

    const openai = new OpenAI({ apiKey: openaiApiKey.value() });
    const { dreamText, mood, language } = request.data;

    if (!dreamText) {
        throw new HttpsError('invalid-argument', 'Missing dreamText');
    }

    // Determine target language (default to English)
    const lang = language || 'en';
    const langMap = {
        'tr': 'Turkish',
        'en': 'English',
        'es': 'Spanish',
        'de': 'German',
        'pt': 'Portuguese'
    };
    const targetLanguage = langMap[lang] || 'English';

    try {
        // --- PASS 1: SYMBOL EXTRACTION (Lightweight) ---
        // Goal: Identify key symbols to look up in our 500-item dictionary
        const extractionPrompt = `
        EXTRACT 3-5 dominant symbols from the dream text.
        Output ONLY a JSON array of strings.
        Example: ["DOG", "MUD", "PARK"]
        `;

        const extractionCompletion = await openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages: [
                { role: "system", content: extractionPrompt },
                { role: "user", content: dreamText }
            ],
            response_format: { type: "json_object" },
            temperature: 0.3, // Low temperature for factual extraction
        });

        let symbols = [];
        try {
            const extractionRaw = JSON.parse(extractionCompletion.choices[0].message.content);
            // Handle various likely JSON keys (symbols, keywords, or just the array if generic)
            symbols = extractionRaw.symbols || extractionRaw.keywords || [];
            if (!Array.isArray(symbols)) symbols = [];
        } catch (e) {
            console.warn("Symbol extraction parsing failed", e);
        }

        console.log("Extracted Symbols:", symbols);

        // --- INTERMEDIATE: DICTIONARY LOOKUP ---
        // Lookup derived from the 500-item dictionary
        const retrievedDefinitions = symbols.map(key => {
            const upperKey = key.toUpperCase();
            // Direct match or partial match in associations? 
            // Our dict keys are UPPERCASE.
            // Let's try direct lookup first, then scan associations if needed.

            let entry = dreamDictionary[upperKey];

            // If not found, try to find a key that *contains* this word (e.g. "TEETH" -> "TEETH FALLING OUT")
            if (!entry) {
                const foundKey = Object.keys(dreamDictionary).find(k => k.includes(upperKey) || upperKey.includes(k));
                if (foundKey) entry = dreamDictionary[foundKey];
            }

            if (entry) {
                return `• ${upperKey}: ${entry.meaning} (Associations: ${entry.associations.join(', ')})`;
            }
            return null;
        }).filter(Boolean).join("\n");

        const dictionaryContext = retrievedDefinitions.length > 0
            ? `\nRELEVANT ARCHETYPES (Use these for symbolic depth):\n${retrievedDefinitions}`
            : "";

        console.log("Dictionary Context:", dictionaryContext);

        // --- PASS 2: INTERPRETATION (User-Defined Jungian Persona) ---
        const systemPrompt = `
    You are a Jungian dream interpretation expert.
    You interpret dreams with psychological depth emotional sensitivity and symbolic awareness.

    You approach every dream as an inner experience of the dreamer.
    All people places and events in dreams are treated as parts of the dreamer’s psyche not as external individuals or real world situations.

    You speak with empathy and emotional awareness.
    You never judge the dreamer and never give advice or instructions.
    You do not suggest actions decisions conversations or changes in real life.
    You do not comment on relationships career family or social behavior.

    You do not predict the future and do not use fate destiny warning or prophecy language.
    You treat death loss and fear symbols as inner transformation and psychological processes.

    Your interpretations aim to offer insight not direction.
    Your tone is calm grounded and humane.
    You help the dreamer feel understood not guided.

    CONTEXT:
    DREAM TEXT: "${dreamText}"
    USER MOOD: "${mood}"
    ${dictionaryContext}

    OUTPUT FORMAT RULES:
    1. Output MUST be a valid JSON object with keys: "title", "interpretation".
    2. "title": An intriguing, tangible title (e.g., 'The Hidden Door', 'The Falling Teeth'). Avoid abstract philosophical terms. Use ${targetLanguage}.
    3. "interpretation": A comprehensive analysis. It MUST be AT LEAST 2 paragraphs (max 120 words total). Separate paragraphs with DOUBLE NEWLINES (\n\n).
    4. Language: EXCLUSIVE USE of ${targetLanguage}.
    5. Do not output markdown, just the JSON.
        `;

        const completion = await openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages: [
                { role: "system", content: systemPrompt },
            ],
            response_format: { type: "json_object" },
            temperature: 0.7,
        });

        const responseContent = JSON.parse(completion.choices[0].message.content);

        // Robust fallback
        const title = responseContent.title || "Dream Analysis";
        let interpretation = responseContent.interpretation || responseContent.analysis || "Interpretation unavailable.";

        return { title, interpretation };
    } catch (error) {
        console.error("Error interpretation:", error);
        throw new HttpsError('internal', "Interpretation failed.");
    }
});

exports.generateDailyTip = onCall({ secrets: [openaiApiKey] }, async (request) => {
    // Rate limit check
    await enforceRateLimit('generateDailyTip', request);

    const openai = new OpenAI({ apiKey: openaiApiKey.value() });

    const { language } = request.data;
    const lang = language || 'en';

    const langMap = {
        'tr': 'Turkish',
        'en': 'English',
        'es': 'Spanish',
        'de': 'German',
        'pt': 'Portuguese'
    };
    const targetLanguage = langMap[lang] || 'English';

    const systemPrompt = `You are a gentle dream-guidance assistant.

Your task is to generate a single, short daily suggestion ("Dream Tip") for the user. 
This is NOT a dream interpretation. 
It should feel supportive, reflective, and related to dream awareness, emotional clarity, or inner exploration.

RULES:
- Keep the tone warm, calm, and inspirational.
- The tip must fit into 1–3 sentences.
- **STRICT BAN:** Do NOT use words like "healing", "journey", "process", "improvement", "step", or "grow".
- **SOFT GUIDANCE ONLY:** Do NOT give specific advice, instruction, diagnosis, or predictions.
- Do NOT use language that implies what the user *should* do, become, or change.
- Keep the suggestion as an open-ended invitation (e.g., "You might reflect on...", "Notice how...").
- Do NOT interpret dreams.
- Keep the suggestion actionable but light (e.g., journaling, reflection, breathing, noticing emotions).
- Avoid therapy-like or medical advice.
- Use a soft, poetic style suited for a dream-themed app.
- Do NOT reference the user's specific life; keep it universal.

The structure should feel like:
1. A gentle invitation toward self-awareness.
2. A small, peaceful action the user can do today.

Reply in ${targetLanguage} language.
`;

    try {
        const completion = await openai.chat.completions.create({
            messages: [
                { role: "system", content: systemPrompt },
                { role: "user", content: "Generate today's dream guidance tip." },
            ],
            model: "gpt-4o-mini",
            temperature: 0.8,
            max_tokens: 150,
        });

        return {
            result: completion.choices[0].message.content,
            usage: completion.usage
        };
    } catch (error) {
        console.error("Error tip:", error);
        throw new HttpsError('internal', error.message);
    }
});

exports.analyzeDreams = onCall({ secrets: [openaiApiKey] }, async (request) => {
    // Rate limit check
    await enforceRateLimit('analyzeDreams', request);

    const openai = new OpenAI({ apiKey: openaiApiKey.value() });

    const { dreams, language } = request.data;
    const lang = language || 'en';

    if (!dreams || !Array.isArray(dreams)) {
        throw new HttpsError('invalid-argument', 'Missing dreams array');
    }

    const systemPrompt = `
You are a weekly Dream Pattern Analysis assistant.

Your task is NOT to interpret a single dream, but to look at all dreams provided for the week and identify patterns, recurring themes, emotional trends, and symbolic clusters. Your tone should be calm, observational, and insightful.

LIMITED DATA RULE:
If fewer than 5 dreams are provided in the weekly set, include this message at the beginning of your analysis:
"${lang === 'tr' ? 'Girdiğin rüya sayısı sınırlı olduğu için analiz genel eğilim üzerinden yapılmıştır.' : 'Due to limited dream data, analysis is based on general trends.'}"

PATTERN ANALYSIS RULES:
For safe weekly dream sets:
- Do NOT interpret dreams individually.
- Identify repeated themes, symbols, moods, or scenes across the week.
- Describe emotional progression (how feelings shift from one dream to another).
- Highlight subconscious tendencies or repeating behaviors.
- Note any symbolic clusters that appear in multiple dreams.
- Keep your tone analytical, warm, and reflective. Move away from "progress" narratives.
- **STRICTLY FORBIDDEN:** Do NOT provide advice, instruction, prediction, or diagnosis.
- **OPEN-ENDED:** All observations must be descriptive (e.g., "This pattern suggests a focus on...") rather than prescriptive (e.g., "You need to...").
- Your analysis must feel personal, thoughtful, and unique.

CRITICAL WRITING RULES:
- ALWAYS speak DIRECTLY to the person reading. Use "sen/senin" in Turkish, "you/your" in English.
- NEVER use the word "kullanıcı" (user) or refer to the reader in third person. 
- NEVER use bold formatting with ** symbols. No **text** ever.
- Write as if speaking directly to this person about THEIR dreams.

WRITING STYLE:
- For all sections: Write in FLOWING PROSE format using complete sentences and paragraphs. 
- Do NOT use bullet points or lists in the actual output.
- Each section should read like a mini-essay speaking directly to "sen/you".

OUTPUT STRUCTURE (STRICT MARKDOWN):
Use ### for headers with numbering format "1)" not "1." - example: "### 1) HEADER". NO **bold** text. NO bullet points in output.

### 1) ${lang === 'tr' ? 'TEKRARLAYAN TEMALAR' : 'RECURRING THEMES'}
Write a flowing paragraph about recurring themes. Speak directly using "sen/senin". Never say "kullanıcı".

### 2) ${lang === 'tr' ? 'DUYGUSAL DÖNGÜLER' : 'EMOTIONAL CYCLES'}
Write a narrative paragraph about emotional progression. Speak directly using "sen/senin". Never say "kullanıcı".

### 3) ${lang === 'tr' ? 'BİLİNÇALTI EĞİLİMLERİ' : 'SUBCONSCIOUS TENDENCIES'}
Write a cohesive paragraph about subconscious patterns. Speak directly using "sen/senin". Never say "kullanıcı".

### 4) ${lang === 'tr' ? 'SEMBOL AĞI' : 'SYMBOL NETWORK'}
Write a flowing paragraph connecting key symbols. Speak directly using "sen/senin". Never say "kullanıcı".

### 5) ${lang === 'tr' ? 'HAFTALIK ÖZET' : 'WEEKLY SUMMARY'}
Write a deeply personal summary paragraph. Speak directly using "sen/senin". Make it feel like a personal letter about where you are in your life journey.

### 6) ${lang === 'tr' ? 'FARKINDALIK İPUCU' : 'AWARENESS TIP'}
Provide a highly personalized and impactful tip speaking directly to "sen/you". Suggest specific actions like music, art, sports, walking, nature, work-life balance, relationships, creative outlets, or mindfulness. Make it actionable and genuinely helpful.

Your response must be in ${lang === 'tr' ? 'Turkish' : 'English'}.
REMEMBER: No "kullanıcı", no **bold**, no bullet points. Always "sen/senin" (you/your). Use "1)" numbering format NOT "1." format.
`;

    try {
        const completion = await openai.chat.completions.create({
            messages: [
                { role: "system", content: systemPrompt },
                { role: "user", content: `Here are the dreams for the week:\n\n${dreams.join('\n\n')}` }
            ],
            model: "gpt-4o-mini",
            temperature: 0.7,
        });

        return {
            result: completion.choices[0].message.content,
            usage: completion.usage
        };
    } catch (error) {
        console.error("Error analysis:", error);
        throw new HttpsError('internal', error.message);
    }
});

// Moon & Planet Synchronization Analysis
exports.analyzeMoonSync = onCall({ secrets: [openaiApiKey] }, async (request) => {
    // Rate limit check
    await enforceRateLimit('analyzeMoonSync', request);

    const openai = new OpenAI({ apiKey: openaiApiKey.value() });

    const { dreamData, language } = request.data;
    const lang = language || 'en';

    if (!dreamData || !Array.isArray(dreamData)) {
        throw new HttpsError('invalid-argument', 'Missing dreamData array');
    }

    const langMap = {
        'tr': 'Turkish',
        'en': 'English',
        'es': 'Spanish',
        'de': 'German',
        'pt': 'Portuguese'
    };
    const targetLanguage = langMap[lang] || 'English';

    const systemPrompt = `
You are a Cosmic Dream Analysis assistant specializing in Moon Phase correlations and Astronomical Events.

Your task is to analyze the relationship between the user's dream journal data and the lunar/cosmic cycle.
You will receive dream data containing:
- Moon Phase (New Moon, Full Moon, etc.)
- Astronomical Events (Super Moon, Blood Moon, Eclipses) - these are CRITICAL if present.
- Dream Vividness (1-3 scale: 1=Vague, 2=Partial, 3=Clear)
- Mood & Intensity (1-3 scale)
- Dream Text

GOAL:
Provide a deep, personalized monthly cosmic analysis that connects the user's psychology and subconscious state to the moon's journey.
The user should feel: "My dreams, the Moon's phases, my clarity of memory, and my emotional world are all connected."

ANALYSIS FRAMEWORK:

### 1) ${lang === 'tr' ? 'AY EVRESİ ETKİSİ' : 'MOON PHASE IMPACT'}
- Focus on the dominant moon phase of the period.
- Explain the known psychological/emotional effects of this phase (e.g., New Moon = new beginnings, Full Moon = high energy/release).
- Connect this to the user's specific dream data (moods, intensity).
- Use a structure like: "In this phase of the Moon, people generally experience X. In your dreams, we see this reflected as Y..."

### 2) ${lang === 'tr' ? 'KOZMİK & ASTRONOMİK OLAYLAR' : 'COSMIC & ASTRONOMICAL EVENTS'}
- **CRITICAL SECTION:** If the data includes "Super Moon", "Blood Moon", "Solar Eclipse", or "Lunar Eclipse", you MUST focus on it here.
- Explain the intense subconscious effects of these events (Super Moon = heightened clarity/emotion, Eclipses = sudden shifts/shadow work).
- **Correlate with Vividness & Intensity:** Analyze if dreams were more vivid (High Vividness) or emotionally intense during these events.
- If there are NO special events, discuss the general lunar flow or transition between phases.
- Example connection: "The presence of the Super Moon likely contributed to the high vividness and intense emotions you recorded..." or "The Solar Eclipse energy might explain the shadowy themes..."

### 3) ${lang === 'tr' ? 'RÜYA YOĞUNLUĞU & BERRAKLIK' : 'DREAM INTENSITY & CLARITY'}
- **DO NOT** just mention word count.
- **NO NUMERIC SCALES:** Never say "between 1 and 3" or "level 2". Use descriptive words:
   - Intensity: "Light", "Moderate", "Deep", "Intense" (Hafif, Orta, Derin, Yoğun).
   - Vividness: "Vague", "Hazy", "Clear", "Vivid" (Silik, Bulanık, Net, Canlı).
- Analyze the TRIAD: **Word Count + Mood Intensity + Vividness**.
- Vividness is a key indicator of awareness. High vividness during specific phases suggests an active subconscious.
- Connect this triad to the moon.
- Example: "This moon phase seems to have triggered shorter but highly vivid dreams, suggesting focused subconscious messages..."

### 4) ${lang === 'tr' ? 'KOZMİK İÇGÖRÜLER' : 'COSMIC INSIGHTS'}
- Synthesize everything: Recurring themes + Moon Phase + Cosmic Events + Emotional Intensity.
- What is the "Soul Message" of this period?
- Focus on themes of release, confrontation, awakening, or rest based on the data.

### 5) ${lang === 'tr' ? 'AY TAVSİYESİ' : 'LUNAR GUIDANCE'}
- Provide a specific, actionable tip based on the current phase and the user's state (anxious vs peaceful, vivid vs vague).
- Suggest alignment practices (meditation, journaling, grounding, water rituals).
- Example: "Given the intense Full Moon energy and your vivid dreams, this is a perfect time for..."

TONE & STYLE:
- **Language:** ${targetLanguage}
- **Voice:** Gentle, mystical but grounded, non-judgmental.
- **Perspective:** DIRECTLY address the user as "YOU" (Sen/Senin). Never use "user" or "the dreamer".
- **Formatting:** Flowing paragraphs. **NO BULLET POINTS**. **NO BOLD TEXT**.
- **Headings:** Use ### 1) Header format.

`;

    // Format dream data for the prompt
    const formattedDreams = dreamData.map((d, i) =>
        `Dream ${i + 1} (${d.date.split('T')[0]}):
   Phase: ${d.moonPhase} (${d.isWaxing ? 'Waxing' : 'Waning'})
   Cosmic Events: ${d.astronomicalEvents && d.astronomicalEvents.length > 0 ? d.astronomicalEvents.join(', ') : 'None'}
   Mood: ${d.mood} (Intensity: ${d.moodIntensity}/3)
   Vividness: ${d.vividness}/3
   Word Count: ${d.wordCount}
   Content: ${d.text.substring(0, 300)}...`
    ).join('\n\n');

    try {
        const completion = await openai.chat.completions.create({
            messages: [
                { role: "system", content: systemPrompt },
                { role: "user", content: `Here is the dream journal data with moon phase and cosmic event info:\n\n${formattedDreams}` }
            ],
            model: "gpt-4o-mini",
            temperature: 0.7,
        });

        return {
            result: completion.choices[0].message.content,
            usage: completion.usage
        };
    } catch (error) {
        console.error("Error moon sync:", error);
        throw new HttpsError('internal', error.message);
    }
});
// Image Generation Feature
exports.generateDreamImage = onCall({ secrets: [openaiApiKey] }, async (request) => {
    // Rate limit check (Generic)
    await enforceRateLimit('generateDreamImage', request);

    // ** AUTHENTICATION CHECK **
    if (!request.auth || !request.auth.uid) {
        console.error("generateDreamImage: No authenticated user");
        throw new HttpsError('unauthenticated', 'User must be authenticated to generate images.');
    }

    const openai = new OpenAI({ apiKey: openaiApiKey.value() });
    const { dreamText, dreamId, isTrial } = request.data;
    const uid = request.auth.uid;

    console.log(`generateDreamImage called. uid=${uid}, dreamId=${dreamId}, isTrial=${isTrial}`);

    if (!dreamText || !dreamId) {
        throw new HttpsError('invalid-argument', 'Missing dreamText or dreamId');
    }

    // Get Storage bucket (explicit bucket name for Firebase project)
    // [PRE-FLIGHT CHECK] Validate storage BEFORE expensive OpenAI calls
    let bucket;
    try {
        bucket = admin.storage().bucket('dream-boat-app.firebasestorage.app');
        console.log(`Storage bucket initialized: ${bucket.name}`);

        // Verify bucket is accessible (prevents wasted API costs)
        const [bucketExists] = await bucket.exists();
        if (!bucketExists) {
            console.error("Storage bucket does not exist or is not accessible");
            throw new HttpsError('failed-precondition', 'Storage not available. Please try again later.');
        }
        console.log("Storage bucket verified accessible");
    } catch (storageErr) {
        console.error("Storage initialization error:", storageErr);
        if (storageErr instanceof HttpsError) throw storageErr;
        throw new HttpsError('internal', 'Storage initialization failed: ' + storageErr.message);
    }

    const filePath = `dream_images/${uid}/${dreamId}.png`;
    const file = bucket.file(filePath);

    // [IDEMPOTENCY CHECK]
    // If image exists, return it immediately. Do NOT consume limit.
    try {
        const [exists] = await file.exists();
        if (exists) {
            console.log(`Image already exists for dream ${dreamId}. Returning cached result.`);
            return {
                imageUrl: file.publicUrl(),
                prompt: "Refined prompt not available (Cached Request)"
            };
        }
    } catch (existsErr) {
        console.error("File exists check error:", existsErr);
        // Continue anyway - might be a transient error
    }

    // 1. Strict Date-Based Rate Limiting (YYYY-MM-DD)
    const db = admin.firestore();
    const userStatsRef = db.doc(`users/${uid}/stats/limits`);

    // Get current UTC Date Key
    const now = new Date();
    const dateKey = now.toISOString().split('T')[0]; // "2026-02-01"

    const statsSnap = await userStatsRef.get();
    const stats = statsSnap.data() || {};

    if (isTrial) {
        // TRIAL Logic: Max 1 image EVER
        if (stats.totalImagesGenerated && stats.totalImagesGenerated >= 1) {
            throw new HttpsError('resource-exhausted', 'Trial limit reached: 1 image total.');
        }
    } else {
        // PAID Logic: Max 1 image PER DAY
        if (stats.lastImageGenDate === dateKey) {
            throw new HttpsError('resource-exhausted', 'Daily limit reached: 1 image per day.');
        }
    }

    try {
        // 2. Prompt Refinement (Styles Anchor)
        // Convert user's raw dream text into a DALL-E optimized prompt
        const refinement = await openai.chat.completions.create({
            messages: [
                { role: "system", content: "You are an AI Art Director. Convert the user's dream description into a single, vivid DALL-E 3 prompt. \n\nSTYLE ANCHORS (Mandatory): Surreal, cinematic lighting, soft ethereal atmosphere, dreamlike quality, highly detailed, masterwork oil painting style. \n\nOutput ONLY the prompt text." },
                { role: "user", content: `Dream: ${dreamText}` }
            ],
            model: "gpt-4o-mini",
            max_tokens: 100,
        });
        const finalPrompt = refinement.choices[0].message.content;

        // 3. Generate Image (DALL-E 3)
        const imageResponse = await openai.images.generate({
            model: "dall-e-3",
            prompt: finalPrompt,
            n: 1,
            size: "1024x1024",
            response_format: "b64_json", // Get buffer directly to upload
        });

        const imageBuffer = Buffer.from(imageResponse.data[0].b64_json, 'base64');

        // 4. Save File (Already defined)
        await file.save(imageBuffer, {
            metadata: { contentType: 'image/png' },
            public: true, // Make public for easy loading
        });

        // 5. Update Limits in Firestore
        await userStatsRef.set({
            lastImageGenDate: dateKey,
            totalImagesGenerated: admin.firestore.FieldValue.increment(1),
            lastImagePrompt: finalPrompt // Audit
        }, { merge: true });

        // 6. Return Public URL
        const publicUrl = file.publicUrl();

        return {
            imageUrl: publicUrl,
            prompt: finalPrompt
        };

    } catch (error) {
        console.error("Error generating image:", error);
        throw new HttpsError('internal', error.message);
    }
});
