class Computer < Player
	attr_reader :code
	COLORS = ["black", "green", "red", "white", "yellow", "blue"]
	def initialize 
		@code = set_code
	end

	def colors 
		COLORS
	end

	private

	def set_code 
		colors = COLORS.shuffle
		generated_code = []
		4.times { generated_code << colors.pop }
		generated_code
	end

end