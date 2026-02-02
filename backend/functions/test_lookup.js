
const { dreamDictionary } = require('./data/dream_dictionary_new');

function testLookup(keys) {
    console.log("Testing Lookup for keys:", keys);
    const retrievedDefinitions = keys.map(key => {
        const upperKey = key.toUpperCase();
        const entry = dreamDictionary[upperKey];

        if (entry) {
            console.log(`[FOUND] ${upperKey}`);
            return `\${upperKey} (\${entry.associations.join(', ')}): \${entry.meaning}`;
        }

        // Fallback
        const foundKey = Object.keys(dreamDictionary).find(k => k.includes(upperKey));
        if (foundKey) {
            console.log(`[PARTIAL] ${upperKey} -> ${foundKey}`);
            const e = dreamDictionary[foundKey];
            return `\${foundKey} (\${e.associations.join(', ')}): \${e.meaning}`;
        }

        console.log(`[MISSING] ${upperKey}`);
        return null;
    }).filter(Boolean).join("\n");

    console.log("\n--- RETRIEVED TEXT ---\n");
    console.log(retrievedDefinitions);
}

// Test case 1: Known keys
testLookup(['SNAKE', 'HOUSE', 'TEETH']);

// Test case 2: Casing and partials
testLookup(['flying', 'water', 'unknownsymbol']);
