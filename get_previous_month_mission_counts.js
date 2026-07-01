import os from 'os';
import path from 'path';
import fs from 'fs';

const home = os.homedir()
const cycleCsvFolder = path.join(home, 'Desktop/cycles')
const files = fs.readdirSync(cycleCsvFolder)

const date = new Date();
date.setDate(1);
date.setMonth(date.getMonth() - 1);
const previousYearMonth = date.toISOString().slice(0, 7).replace('-', '');

const cycle = parseInt(process.argv[2])
const prevMonthCycleCsv = files.find(f => f.startsWith(`${previousYearMonth}`) && f.endsWith(`c${cycle}.csv`))
if (!prevMonthCycleCsv) {
	console.log('0 0 0 0')
	process.exit(0);
}

const contents = fs.readFileSync(path.join(cycleCsvFolder, prevMonthCycleCsv), 'utf8')
const lines = contents.split("\n").slice(1, -1)

let totalDays = 0
let halfDays = 0
let successDays = 0
let failDays = 0

const res2 = []

lines.map(line => {
	const build = line.split(',')[0]
	const learn = line.split(',')[1]

	const res = getNumberForDay(build, learn)
	res2.push(res)
	if (res === -1) {
		failDays += 1;
		totalDays += 1
	}
	if (res === 1) {
		halfDays += 1;
		totalDays += 1
	}
	if (res === 2) {
		successDays += 1;
		totalDays += 1
	}

})
console.log(`${successDays} ${halfDays} ${failDays} ${totalDays}`)

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
