import path from 'path';
import { getMissionEntriesFromCsv } from './mission_utils.js';

const cycleCsvFolder = process.argv[2];
const cycle = parseInt(process.argv[3])

const now = new Date();
const yearMonth = now.toISOString().slice(0, 7).replace('-', '');

console.log(getMissionEntriesFromCsv(path.join(cycleCsvFolder, `${yearMonth}c${cycle}.csv`)))
