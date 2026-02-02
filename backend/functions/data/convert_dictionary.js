const fs = require('fs');
const path = require('path');

const rawPath = path.join(__dirname, 'raw_dictionary.txt');
const outPath = path.join(__dirname, 'dream_dictionary_new.js');

const raw = fs.readFileSync(rawPath, 'utf-8');
const lines = raw.split('\n');

const dictionary = {};

lines.forEach(line => {
    line = line.trim();
    if (!line) return;

    // Pattern: 1. OCEAN (Waves, Salt, Abyss, Horizon, Tides) -> THE COLLECTIVE UNCONSCIOUS
    const match = line.match(/^\d+\.\s+([^(]+)\s+\(([^)]+)\)\s+->\s+(.+)$/);
    if (!match) {
        console.error('Skipping invalid line:', line);
        return;
    }

    const key = match[1].trim(); // OCEAN
    const associationString = match[2]; // Waves, Salt, Abyss...
    const meaning = match[3].trim(); // THE COLLECTIVE UNCONSCIOUS

    // Split associations by comma
    const associations = associationString.split(',').map(s => s.trim());

    dictionary[key] = {
        meaning: meaning,
        associations: associations
    };
});

const fileContent = `// Auto-generated dream dictionary
// 500 items. Jungian Archetypes.
exports.dreamDictionary = ${JSON.stringify(dictionary, null, 2)};
`;

fs.writeFileSync(outPath, fileContent);
console.log('Dictionary generated at:', outPath);
