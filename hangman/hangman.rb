class Game
	def initialize
	end

	def play
		intro
		secret_word = random_word.downcase
		hidden_word = hide_word(secret_word)
		puts "The secret word: #{hidden_word} (#{hidden_word.length} letters)"

		tries = 6
		wrong_guesses = []
		while tries != 0 && !won?(hidden_word)
			puts "Wrong guesses: #{wrong_guesses.join(" ")}" if tries < 6
			print "Your guess: " 
			guess = gets.chomp.downcase
			if guess_valid?(guess)
				if correct_guess?(guess, secret_word)
					# correct! reveal char position in hidden word
					puts "CORRECT!"
					positions = hidden_char_position(guess, secret_word)
					hidden_word = show_correct_guesses(secret_word, hidden_word, positions)
					puts hidden_word
					puts ""
					next
				else
					# wrong! try again! tries - 1
					tries -= 1
					wrong_guesses << guess unless wrong_guesses.include?(guess)
					puts "WRONG guess! guesses left: #{tries}"
					puts hidden_word
					puts ""
					if tries == 0
						puts "Game Over!! The secret word was: #{secret_word}"
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
	def hide_word(word)
		hidden_word = word.gsub(/./,"-")
	end

	# replaces chars that has not been guessed correct with a dash "-" based on the position from char_positions
	def show_correct_guesses(secret_word, hidden_word, positions)
		positions.each do |position|
			secret_word = secret_word.gsub(secret_word[position], hidden_word[position])
		end
		secret_word
	end

	# returns an array of the positions that has not been guessed rights
	def hidden_char_position(guess, secret_word)
			positions = []
			secret_word.each_char.with_index do |char, index|
				if char != guess
					positions << index
				end
			end
			positions
	end


	# checks if the char guessed by the player is in the secret word or not
	def correct_guess?(guess, word)
		return true if word.include?(guess)
		false
	end

	# checks if the player's guess is valid
	def guess_valid?(guess)
		return true if guess.is_a?(String) && guess.length == 1
		false
	end

	def won?(hidden_word)
		if !hidden_word.include?("-")
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
		when "yes" then play
		when "no" then puts "Bye!"
		else puts "Choice not valid"
		end
	end
	
end

game = Game.new
game.play