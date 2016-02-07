class Player
	
	def make_guess
		guess = gets.chomp.downcase.split
	end

	def set_code(code)
		code = gets.chomp.split
	end
end