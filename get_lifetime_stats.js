import path from 'path';
import fs from 'fs';
import { getMissionStatsFromCsv } from './mission_utils.js';

const cycleCsvFolder = process.argv[2];
const cycle = parseInt(process.argv[3])

const files = fs.readdirSync(cycleCsvFolder)
const summaryJsonFilePath = path.join(cycleCsvFolder, `c${cycle}Summary.json`)

const summaryJsonExists = files.find(fileName => fileName === `c${cycle}Summary.json`);
if (!summaryJsonExists) {
	fs.writeFileSync(summaryJsonFilePath, '{}', 'utf8')
}

const summaryJsonContents = fs.readFileSync(summaryJsonFilePath, 'utf8')
const summaryJsonParsed = JSON.parse(summaryJsonContents)
const csvFileNames = files.filter(name => name.endsWith('.csv'));

let totalSuccessDays = 0;
let totalFailDays = 0;
let totalHalfDays = 0;
let totalDays = 0

csvFileNames.forEach(csvFileName => {
	let stats = summaryJsonParsed[csvFileName];
	if (!stats) {
		stats = summaryJsonParsed[csvFileName] = getMissionStatsFromCsv(path.join(cycleCsvFolder, csvFileName))
	}

	totalSuccessDays += stats.totalSuccess
	totalFailDays += stats.totalFail
	totalHalfDays += stats.totalHalf
	totalDays += stats.totalDays
})
fs.writeFileSync(summaryJsonFilePath, JSON.stringify(summaryJsonParsed, null, 2), 'utf8')

console.log(`${totalSuccessDays} ${totalHalfDays} ${totalFailDays} ${totalDays}`)
