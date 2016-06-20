require 'csv'
require 'sunlight/congress'
require 'erb'
require 'date'

# turn nil zipcodes to "", pads zipcodes less than 5 numbers with zeros, takes the first five numbers from zipcodes with more than 5 numbers 
def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, "0")[0..4]
end

# gets legislator by their zipcode
def legislators_by_zipcode(zipcode)
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

# writes thank you letter using the form_letter template and saves them to dir output 
def save_thankyou_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists? "output"

	filename = "output/thanks#{id}.html"

	File.open(filename, "w") do |file|
		file.puts form_letter
	end
end

# removes any non-digit charachter from phonenum, makes sure phonenum is 10 chars
def clean_phone_number(phone_number)
	phone_number = phone_number.to_s.gsub(/\D+/,"") 
	if phone_number.nil?
		"N/A"
	elsif phone_number.length < 10
		return "Bad Number"
	elsif phone_number.length == 11
		if phone_number[0] == "1"
			phone_number = phone_number[1..-1]
		else
			return "Bad Number"
		end
	elsif phone_number.length > 11
		return "Bad Number"		
	end
	phone_number[0..2] + '-' + phone_number[3..5] + '-' + phone_number[6..9]
end

# returns a hash containg reg date and time(month-day-year hour:minute)
def reg_date_time(reg_date)
	reg_date = reg_date.gsub('/', '-')
	date = DateTime.strptime(reg_date, '%m-%d-%y %H:%M')
end

def week_day(wday)
	case wday
	when 0 then "Sunday"
	when 1 then "Monday"
	when 2 then "Tuesday"
	when 3 then "Wednesday"
	when 4 then "Thursday"
	when 5 then "Friday"
	when 6 then "Saturday"
	end
end

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

puts "Event Manager initialized!"
puts " "

template_letter = File.read("form_letter.erb")
erb_template = ERB.new(template_letter)
peak_hours = Hash.new(0)
peak_wdays = Hash.new(0)

contents = CSV.open("event_attendees.csv", headers: true, header_converters: :symbol) 
contents.each_with_index do |row, index|
	id = row[0]
	name = row[:first_name]
	puts phone_number =  clean_phone_number(row[:homephone])
	reg_date = row[:regdate]
	
	zipcode = clean_zipcode(row[:zipcode])

	legislators = legislators_by_zipcode(zipcode)

	form_letter = erb_template.result(binding)

	save_thankyou_letters(id, form_letter)

	reg_hour = reg_date_time(reg_date).hour
	reg_day = reg_date_time(reg_date).wday


	peak_hours[reg_hour] += 1
	peak_wdays[reg_day] += 1
end

peak_hours = peak_hours.sort_by { |a,b| b }
peak_hours.reverse!
puts "Peak hours: "
peak_hours.each do |hour, times_registered|
	puts "At hour #{hour}:00, #{times_registered} people registered."
end

peak_wdays = peak_wdays.sort_by { |a,b| b }
peak_wdays.reverse!
puts "Peak Days: "
peak_wdays.each do |day, times_registered|
	puts "At day #{week_day(day)}, #{times_registered} people registered."
end
