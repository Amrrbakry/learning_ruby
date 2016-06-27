require 'socket'
require 'json'
 
host = 'localhost'     # The web server
port = 2000                           # Default HTTP port
get_path = "/index.html"                 # The file we want 
post_path = "/thanks.html"

# This is the HTTP request we send to fetch a file
puts "Do you want to send a GET or a POST request?"
request = gets.chomp.upcase
case request
when "GET"
	request = "GET #{get_path} HTTP/1.0\r\n\r\n"
when "POST"
	print "Please enter a name: "
	name = gets.chomp.capitalize
	print "Please enter an email: "
	email = gets.chomp
	form_info = { :user => {:name => name, :email => email} }
	request = "POST #{post_path} HTTP/1.0\r\nContent-Length: #{form_info.to_json.bytesize}\r\n\r\n#{form_info.to_json}"
else
	puts "invalid request method"
end

socket = TCPSocket.open(host,port)  # Connect to server

socket.print(request)               # Send request
response = socket.read             # Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2) 
print headers, body                          # And display it