/**
 * outputs `${successDays} ${halfDays} ${failDays} ${totalDays}` mission counts for previous calendar month for given cycle.
 * Expects there to be a CSV with appropriate name given previous month and cycle number else outputs default of '0 0 0 0'.
 * Unexpected behaviour if CSV contents are not in expected format.
 */
import path from 'path';
import { getMissionStatsFromCsv } from './mission_utils.js';

const cycleCsvFolder = process.argv[2];
const cycle = parseInt(process.argv[3])

const date = new Date();
date.setDate(1);
date.setMonth(date.getMonth() - 1);
const previousYearMonth = date.toISOString().slice(0, 7).replace('-', '');

const stats = getMissionStatsFromCsv(path.join(cycleCsvFolder, `${previousYearMonth}c${cycle}.csv`))
console.log(`${stats.totalSuccess} ${stats.totalHalf} ${stats.totalFail} ${stats.totalDays}`)
