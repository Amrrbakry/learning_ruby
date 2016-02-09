class Player
	
	# gets the player's guess of four colors
	def make_guess
		guess = gets.chomp.downcase.split
	end

	# lets the player set a code of fours colors
	def set_code(code)
		code = gets.chomp.split
	end
end