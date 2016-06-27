require 'socket'

server = TCPServer.open(2000) # Socket to listen on port 2000
loop {  # Servers run forever
	client = server.accept # Wait for a client to connect
	request = client.gets # getting request from web_browser
	req_parts = request.split(" ") # parsing the request 
	request_method, requested_file, http_version = req_parts[0], req_parts[1].split("/")[-1], req_parts[2] #parsing the request
	case request_method
	when "GET"
		if File::exist?(requested_file)
			client.puts "#{http_version} 200 OK"
			client.puts requested_file.size
			client.puts File.open(requested_file).read
		else
			client.puts "404 Not Found"
		end
	else
		client.puts "500 Server Error"
	end	

	client.puts "Closing connection now. Bye!"
	client.close # Disconnect from the client
}