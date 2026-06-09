import os from 'os';
import path from 'path';
import fs from 'fs';

const home = os.homedir()
const cycleCsvFolder = path.join(home, 'Desktop/cycles')
const files = fs.readdirSync(cycleCsvFolder)

const yearMonth = new Date().toISOString().slice(0, 7).replace('-', '');
const cycle = parseInt(process.argv[2])
const currentCycleCsv = files.find(f => f.startsWith(`${yearMonth}`) && f.endsWith(`c${cycle}.csv`))
if (!currentCycleCsv) {
	//if no CSV found, put all days as blank
	const daysInCurrentMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();
	const entries = Array(daysInCurrentMonth).fill('0')
	console.log(entries)
}

const contents = fs.readFileSync(path.join(cycleCsvFolder, currentCycleCsv), 'utf8')
const lines = contents.split("\n").slice(1, -1)

let entries = ""
lines.map(line => {
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
