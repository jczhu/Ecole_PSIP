# Ecole_PSIP Challenge Problem 2

My solution for the Ecole PSIP challenge puzzle 2, which takes input from files (which may be one of three formats, examples of the formats are in the text files ending with delimited.txt), sorts the input in 3 different ways, and puts all the sorted output in a single output.txt file.

## Things to improve
1. Output is in an incorrect format. Dates should use forward slashes instead of dashes and come before colors. Leading zeros should also be removed (e.g. 03/04/1999 should be 3/4/1999).
2. Efficiency. I iterate through my parsed list of input multiple times. E.g. for the dates, I go through once to get the dates (to convert to a form parseable by Ruby's "Date" class), another time to remove the dates, and then appending the newly formatted dates to the end of the list.
