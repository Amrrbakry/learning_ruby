class Game
	attr_reader :player, :com, :code
	@@won = 0
	def initialize 
		@player = Player.new
		@com = Computer.new
		@code = @com.code
	end

	def start_game
		puts "Welcome to Mastermind!"
		puts ""
		puts "The computer will make a random code of four colors and you have 12 tries to guess the code and win the game. Good Luck!"
		puts "-------------------------------------------------------------------------------------------------------------"
		puts "ALL COLORS: #{@com.colors.join(' - ')}"
	end

	def play 
		turn = 12
		start_game
		while turn != 0 
			break if @@won == 1
			puts "Enter your guessed code separated by a space -- You have #{turn} tries left"
			puts "-----------------------------------------------"
			print "Your guess >> " 
			guess = @player.make_guess
			puts ""
			if valid_guess?(guess)
				match(guess)
			else
				puts "INVALID INPUT! Please enter four colors as your guess."
			end
			puts "Your last guess was: #{guess.join(' - ')}"
			turn -= 1
		end
		lost if turn == 0
	end

	private

	def match(guess)
		exact_match = 0
		color_match = 0
		guess.each_with_index do |color, index|
			if @code.include?(color)
				color_match += 1
				@code.each_with_index do |code_color, code_index|
					if code_color == color && code_index == index
						exact_match += 1
					end
				end
			else
				next
			end
		end
		return match_result(exact_match, color_match)
	end

	def match_result(exact_match, color_match)
		if exact_match == 4
			@@won = 1
			puts "YOU WON!!!!"
		else
			puts "You guessed #{exact_match} exact matches and #{color_match - exact_match} color matches. Try again!" 
			puts ""
			@@won = 0
		end
	end

	def valid_guess?(guess)
		return false if guess.size != 4
		true
	end

	def lost
		puts "You lost. The correct code was #{@code.join(' ')}"
	end

end