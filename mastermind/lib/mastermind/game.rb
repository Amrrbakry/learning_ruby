class Game
	attr_reader :player, :com
	def initialize 
		@player = Player.new
		@computer = Computer.new
	end

	# starts the game
	def play
		start_game
		play_mode
	end

	# puts an intro the game 
	def start_game
		puts "Welcome to Mastermind!"
		puts "-------------------------------------------------------------------------------------------------------------"
		puts ""
	end

	private

	# asks the player whether they want to play as the code maker or the code breaker
	def play_mode
		puts "Do you want to play as code maker or code breaker?"
		puts "Enter 'M' for code maker or 'B' for code breaker"
		choice = gets.chomp
		if choice == "M" || choice == "m"
			play_as_codemaker
		elsif choice.upcase == "B" || choice == "b"
			play_as_codebreaker
		else
			puts "The choice you entered in invaild! Please enter 'M' or 'B' to play."
		end
	end

	# lets the computer set a random code of four colors
	def play_as_codebreaker 
		code = @computer.set_code
		puts "The computer has made a random code of four colors, and you have 12 turns to guess it correctly and win. Good Luck!"
		puts ""
		tries = 12
		while tries != 0 
			puts "Enter your guessed code separated by a space -- You have #{tries} tries left"
			puts "-----------------------------------------------"
			puts "ALL COLORS: #{@computer.colors.join(' - ')}"
			print "Your guess >> " 
			guess = @player.make_guess
			puts ""
			if valid_guess?(guess)
				match(guess, code)
			else
				puts "INVALID INPUT! Please enter four colors as your guess separated by a space."
			end
			puts "Your last guess was: #{guess.join(' - ')}"
			tries -= 1
		end
		lost if tries == 0
		puts "The correct code was #{code.join(' ')}"
		play_again
	end

	# matches the player's guess with code and passes the match results to feedback
	def match(guess, code)
		exact_match = 0
		color_match = 0
		guess.each_with_index do |color, index|
			if code.include?(color)
				color_match += 1
				code.each_with_index do |code_color, code_index|
					if code_color == color && code_index == index
						exact_match += 1
					end
				end
			else
				next
			end
		end
		if exact_match == 4
			puts "YOU WIN! You guessed the four colors correctly."
			play_again
		else
			feedback(exact_match, color_match)
		end
	end

	# returns feedback on the player's guess based on the results supplied by the match method
	def feedback(exact_match, color_match)
			puts "You guessed #{exact_match} exact matches and #{color_match - exact_match} color matches. Try again!" 
			puts ""
	end

	# checks if the user enterd a vaild guess consisting of four colors
	def valid_guess?(guess)
		return false if guess.size != 4
		true
	end

	def lost
		puts "YOU LOST!"
	end

	# asks the player if they want to play again
	def play_again
		puts "Do you want to play again? (y/n)"
		answer = gets.chomp
		if answer == "y" || answer == "Y"
			play
		else
			exit
		end
	end

end