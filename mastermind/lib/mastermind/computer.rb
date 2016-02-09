class Computer 
	COLORS = ["black", "green", "red", "white", "yellow", "blue"]
	def initialize 
	end

	#returns all the colors available
	def colors 
		COLORS
	end

	# returns a random code of four colors 
	def set_code 
		colors = COLORS.sample(4)
		colors
	end

end