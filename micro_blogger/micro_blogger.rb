require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing MicroBlogger!"
		@client = JumpstartAuth.twitter
	end

	def run
		puts "Welcome to the JSL Twitter Client"

		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split
			command = parts[0]
			case command
			when "q" then puts "Goodbye!"
			when "t" then tweet(parts[1..-1].join)
			when "d" then dm(parts[1], parts[2..-1].join)
			when "spam" then spam_my_followers(parts[1..-1].join)
			when "lt" then last_tweet
			else puts "Sorry! I don't know how to #{command}"
			end
		end
	end

	private 

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "Message is over than the 140 chars limit!"
		end
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message: "
		puts message
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
		if screen_names.include?(target)
			message = "d #{target} #{message}"
			tweet(message)
		else
			puts "You can't DM this person! They must be following you."
		end
	end

   def last_tweet
      friends = @client.friends
      friends = friends.each{ |friend| friend.screen_name.first.downcase }
      friends.each do |friend|
        friend_lt = friend.status.created_at
        puts "#{friend.screen_name.first} said this on #{friend_lt.strftime("%A, %b %d")}..."
        puts "#{friend.status.text}"            
        puts ""
    	end
   end

	def spam_my_followers(message)
		screen_names = followers_list
		screen_names.each { |follower| dm(follower[0], message) }
	end	

	def followers_list
		screen_names = []
		@client.followers.collect { |follower| screen_names << @client.user(follower).screen_name }
	end

end

blogger = MicroBlogger.new
blogger.run