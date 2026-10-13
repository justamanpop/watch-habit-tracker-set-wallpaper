import path from 'path';
import fs from 'fs';

const cycleCsvFolder = process.argv[2];
const cycle = parseInt(process.argv[3])
const files = fs.readdirSync(cycleCsvFolder)

const now = new Date();
const yearMonth = now.toISOString().slice(0, 7).replace('-', '');
const daysInCurrentMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();
const currentCycleCsv = files.find(f => f.startsWith(`${yearMonth}`) && f.endsWith(`c${cycle}.csv`))

if (!currentCycleCsv) {
	//if no CSV found, put all days as blank
	const entries = Array(daysInCurrentMonth).fill('0').join(' ')
	console.log(entries)
	process.exit(0);
}

const contents = fs.readFileSync(path.join(cycleCsvFolder, currentCycleCsv), 'utf8')
const nonHeaderlines = contents.split("\n").slice(1)

const lines = nonHeaderlines.filter(l => l.trim() !== '')

// const lines = contents.split("\n").slice(1, -1)

const padding = Array(daysInCurrentMonth - lines.length).fill('NA,NA')
const paddedLines = lines.concat(padding)

let entries = ""
paddedLines.map(line => {
	const build = line.split(',')[0]
	const learn = line.split(',')[1]
	entries += `${getNumberForDay(build, learn)} `
})
entries.trim();
console.log(entries)


/**
	* -1 is red, 0 is white, 1 is yellow and 2 is green
	*/
function getNumberForDay(build, learn) {
	if (build === 'FAIL') {
		if (learn === 'DONE') {
			return 1
		} else {
			return -1
		}

	}

	if (build === 'DONE') {
		if (learn === 'FAIL') {
			return 1
		} else {
			return 2
		}
	}

	if (build === 'NA') {
		if (learn === 'DONE') {
			return 2;
		} else if (learn === 'FAIL') {
			return -1
		} else {
			return 0
		}
	}
}
