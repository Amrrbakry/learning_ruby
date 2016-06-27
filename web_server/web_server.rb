require 'socket'
require 'json'

server = TCPServer.open(2000) # Socket to listen on port 2000
loop {  # Servers run forever
	client = server.accept # Wait for a client to connect
	request = client.read_nonblock(256) # getting request from web_browser
	headers, body = request.split("\r\n\r\n", 2) # parsing the request 
	headers = headers.split(" ")
	request_method, requested_file, http_version, content_length, = headers[0], headers[1].split("/")[-1], headers[2], headers[4] #parsing the request
	case request_method
	when "GET"
		if File::exist?(requested_file)
			file = File.open(requested_file).read
			client.puts "#{http_version} 200 OK"
			client.puts(Time.now.ctime)
			client.puts "Content-Type: text/html"
			client.puts "Content-Length: #{file.bytesize}"
			client.puts file
		else
			client.puts "404 Not Found"
		end
	when "POST"
		file = File.open(requested_file).read
		client.puts "#{http_version} 200 OK"
		client.puts(Time.now.ctime)
		client.puts "Content-Type: text/html"
		client.puts "Content-Length: #{file.bytesize}"
		params = JSON.parse(body)
		user_data = "<li>name: #{params['user']['name']}</li>\n\t  <li>Email: #{params['user']['email']}</li>"
		client.puts file.gsub("<%= yield %>", user_data)
	else
		client.puts "500 Server Error"
	end	

	client.puts "Closing connection now. Bye!"
	client.close # Disconnect from the client
}