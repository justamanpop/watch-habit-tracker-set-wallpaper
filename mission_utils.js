import fs from 'fs';

/**
 * Gets total number of success, fail and half days from a month CSV file.
 * Expects CSV file to be in particular format, else undefined behaviour
 */
export function getMissionStatsFromCsv(csvFilePath) {
	const csvExists = fs.existsSync(csvFilePath);
	if (!csvExists) {
		return {
			totalFail: 0, totalSuccess: 0, totalHalf: 0, totalDays: 0
		}
	}

	const contents = fs.readFileSync(csvFilePath, 'utf8')
	const nonHeaderlines = contents.split("\n").slice(1)

	const lines = nonHeaderlines.filter(l => l.trim() !== '')

	let totalDays = 0
	let totalSuccess = 0
	let totalFail = 0
	let totalHalf = 0

	lines.map(line => {
		const numberForDay = getNumberForDay(line);
		switch (numberForDay) {
			case -1:
				totalDays += 1;
				totalFail += 1;
				break;
			case 1:
				totalDays += 1;
				totalHalf += 1;
				break;
			case 2:
				totalDays += 1;
				totalSuccess += 1;
				break;
		}
	})

	return {
		totalFail, totalSuccess, totalHalf, totalDays
	}

}


/**
	* -1 is red, representing failure if both tasks failed, or one task failed and one N/A
	*  0 is white, representing an inapplicable day, both tasks are N/A
	*  1 is yellow, representing a half successful day with one fail and one success.
	*  2 is green, representing a successful day, both tasks are success, or one task success and one N/A.
	*/
function getNumberForDay(csvRow) {
	const build = csvRow.split(',')[0]
	const learn = csvRow.split(',')[1]

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
