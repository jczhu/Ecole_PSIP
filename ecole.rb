require 'Date'

# reading in files and parsing s.t. each record is a new row in the array
# and each row is further broken down into "words" (last name, first name, 
# date, etc.)
records = []
Dir["*delimited.txt"].each do |filename|
	File.open(filename, "r") do |f|
		f.each_line do |line|
			words = line.split(/[\s,|]/)

			# Remove empty elements from the array.
			words.delete_if{|e| e.length == 0}

			# if there are >5 elements, one is a middle (?) name and won't 
			# be used, so delete it (always the 3rd elt, after first/lastname)
			if words.length > 5
				words.delete_at(2)
			end

			# then convert the remaining single letter (M/F) to Male and Female
			words.map!{|x| x == "F" ? "Female": x}
			words.map!{|x| x == "M" ? "Male": x}

			# remove date, convert to parseable format, append at end
			# probably not most efficient way since iterating multiple times, 
			# but the best way I could think of
			record_date = words.select {|s| s =~ /\d+/}[0]
			words.reject! {|item| item =~ /[\d]/} 
			# converting dates to same format, then swapping month and day
			# order so Date class can parse it and compare dates
			record_date = record_date.gsub('-', '/')
			parseable_date = Date.strptime(record_date, "%m/%d/%Y").strftime("%d-%m-%Y")

			words.insert(3, record_date) # put slash-separated date in words list

			# also put copy of parseable date for sorting
			# this is the 6th (index 5) column; will not be part of output
			words.push(parseable_date) 
			records.push(words)
		end
	end
end
output = File.open("output.txt", "w")

#-----------------------------------------------------------------------------
# sorting by female first then male; then within each group, sort by last name 
# here, I sort female first by sorting lexicographically by the 3rd element
output << "Output 1:\n"
output1 = records.sort_by{|r| [r[2], r[0]]}
# then for each row, join the words with a space and append to file
output1.each do |row|
	output << row[0..4].join(' ')
	output << "\n"
end

#-----------------------------------------------------------------------------
# first by date, then male before female, then by last name
# here, I sort male first by sorting by length, since length of 
# "male" < length of "female"
output << "\nOutput 2:\n"
output2 = records.sort_by{|r| [Date.parse(r[5]), r[2].length, r[0]]}
# then for each row, join the words with a space and append to file
output2.each do |row|
	output << row[0..4].join(' ')
	output << "\n"
end

#-----------------------------------------------------------------------------
# reverse alphabetical order by last names
output << "\nOutput 3:\n"
output3 = records.sort_by{|r| r[0]}.reverse
# then for each row, join the words with a space and append to file
output3.each do |row|
	output << row[0..4].join(' ')
	output << "\n"
end

output.close
