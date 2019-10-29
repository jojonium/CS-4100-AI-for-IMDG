const fs = require('fs');
const lineReader = require('readline');

lr = lineReader.createInterface({
	input: fs.createReadStream('descriptions.txt')
});

lr.on('line', line => {
	const words = line.split(' ');
	let first = true;
	for (let i = 0; i < words.length; ++i) {
		let word = clean(words[i]); // strip out invalid characters
		// if the word is all invalid characters skip it
		if (word) {
			if (first) {
				// save this word if it's the first one of a line
				starts.push(word);
				first = false;
			}
			// add this word to the table if it isn't already there
			if (!markovChain[word]) {
				markovChain[word] = {total: 0, followUps: {}};
			}
			let j = 1;
			// look for the next valid word and add it as a followup
			while (i + j <= words.length) {
				let next;
				if (i + j === words.length) {
					// add the end-of-line case
					next = '\n';
				} else {
					next = clean(words[i + j]);
				}
				if (next) {
					markovChain[word]['total']++;
					// if this followup is new add it as a new one
					if (!markovChain[word]['followUps'][next])
						markovChain[word]['followUps'][next] = 1;
					else
						// otherwise increment the existing followup
						markovChain[word]['followUps'][next]++;
					break;
				} else {
					j++;
				}
			}
		}
	}
	// cover the end case
});

lr.on('close', () => {
	// when done constructing table
	let out = '';
	let current = starts[Math.floor(Math.random() * starts.length)];
	out += current + ' ';
	do {
		current = pickWord(markovChain, current);
		out += current + ' ';
	} while (current != '\n')
	
	console.log(out);
});

// returns a lowercase version of a word with all non-alphanumeric characters
// stripped out
const clean = (word) => {
	return word.toLowerCase().replace(/[\W_]/g, '');
};

// picks a followup to a given word from the markovChain
const pickWord = (markovChain, word) => {
	if (!markovChain[word]) {
		throw 'Word ' + word + ' isn\'t in this Markov Chain table';
	} else {
		let n = Math.random() * markovChain[word]['total'];
		let t = 0;
		for (let w in markovChain[word]['followUps']) {
			t += markovChain[word]['followUps'][w];
			if (n <= t)
				return w;
		}
	}
};

const markovChain = {};
let starts = [];
