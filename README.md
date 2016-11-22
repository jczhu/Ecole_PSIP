# Ecole_PSIP Challenge Problem 2

My solution for the Ecole PSIP challenge puzzle 2, which takes input from files (which may be one of three formats, examples of the formats are in the text files ending with delimited.txt), sorts the input in 3 different ways, and puts all the sorted output in a single output.txt file.

## Things to improve
1. *Fixed*: ~~Output is in an incorrect format. Dates should use forward slashes instead of dashes and come before colors. Leading zeros should also be removed (e.g. 03/04/1999 should be 3/4/1999). The month/day order was also incorrect.~~
2. Efficiency. I iterate through my parsed list of input multiple times. Notably, I iterate through each entry multiple times to parse the input into a particular format (M/F to Male/Female, making date parseable by the Ruby Date class).
3. Solves a very specific problem. While appropriate within the scope of the challenge problem, my solution makes a lot of assumptions, mostly about the format of the input and output. In a more general context, I would need to take care of more cases and/or catch improper formatting.
