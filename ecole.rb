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
			records.push(words)
		end
	end
end

p records
output = File.open("output.txt", "w")

#-----------------------------------------------------------------------------
# sorting by female first then male; then within each group, sort by last name 
output << "Output 1:"
output1 = records.sort_by{|r| [r[2], r[0]]}
# then join

output.close
