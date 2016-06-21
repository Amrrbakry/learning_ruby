class Game
	def initialize
		@tries = 6
		@secret_word = random_word.downcase
		@hidden_word = hide_secret_word
	end

	def play
		intro
		puts "The secret word: #{@hidden_word} (#{@hidden_word.length} letters)"

		wrong_guesses = []
		while @tries != 0 && !won?
			show_hangman
			puts "Wrong guesses: #{wrong_guesses.join(" ")}" if @tries < 6
			print "Your guess: " 
			guess = gets.chomp.downcase
			if guess_valid?(guess)
				if correct_guess?(guess)
					# correct! reveal char position in hidden word
					puts "CORRECT!"
					positions = hidden_char_position(guess)
					@hidden_word = show_correct_guesses(positions)
					puts @hidden_word
					puts ""
					next
				else
					# wrong! try again! tries - 1
					@tries -= 1
					wrong_guesses << guess unless wrong_guesses.include?(guess)
					puts "WRONG guess! guesses left: #{@tries}"
					puts @hidden_word
					puts ""
					if lost?
						show_hangman(@tries)
						puts "Game Over!! The secret word was: #{@secret_word}"
						puts ""
						play_again
					end
				end
			else
				puts "Invalid guess!Please enter a valid guess."
				next
			end
		end

	end

	private

	def intro
		puts "WELCOME TO HANGMAN"
		puts ""
		puts "Can you guess the secret word??? You have 6 tries to do so!"
		puts ""
	end

	def show_hangman
		case @tries
		when 6
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "              |".center(70)
			puts	 "             |".center(70)
			puts	 "             |".center(70)
			puts	 "              |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 5
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "   O         |".center(70)
			puts	 "             |".center(70)
			puts	 "             |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 4
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "   O         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 3
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 2
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O/        |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 1
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O/        |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   /          |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 0
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O/        |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "  / \\        |".center(70)
			puts     "             |".center(70)
			puts "\n"
		end
	end

	# picks a random word(5 to 12 chars long) from the words.txt dictionary
	def random_word
		file = File.read("words.txt")
		words = file.split
		loop do |word|
			word = words.sample
			if word.length >= 5 && word.length <= 12
				return word
			else
				next
			end
		end
	end

	# replaces word letters with underscores to hide them 
	def hide_secret_word
		@hidden_word = @secret_word.gsub(/./,"-")
	end

	# replaces chars that has not been guessed correct with a dash "-" based on the position from char_positions
	def show_correct_guesses(positions)
		correct_guess = @secret_word
		positions.each do |position|
			correct_guess = correct_guess.gsub(correct_guess[position], @hidden_word[position])
		end
		correct_guess
	end

	# returns an array of the positions that has not been guessed rights
	def hidden_char_position(guess)
			positions = []
			@secret_word.each_char.with_index do |char, index|
				if char != guess
					positions << index
				end
			end
			positions
	end


	# checks if the char guessed by the player is in the secret word or not
	def correct_guess?(guess)
		return true if @secret_word.include?(guess)
		false
	end

	# checks if the player's guess is valid
	def guess_valid?(guess)
		return true if guess.is_a?(String) && guess.length == 1
		false
	end

	def lost?
		return true if @tries == 0
	end

	def won?
		if !@hidden_word.include?("-")
			puts "YOU WIN!"
			play_again
			true
		end
		false
	end

	def play_again
		puts "Do you want to play again? (yes/no)"
		choice = gets.chomp.downcase
		case choice
		when "yes"
			reset
			play
		when "no"
			puts "Bye!"
			exit
		else 
			puts "Choice not valid"
		end
	end

	def reset
		@secret_word = random_word.downcase
		@hidden_word = hide_secret_word
		@tries = 6
	end
	
end

game = Game.new
game.play