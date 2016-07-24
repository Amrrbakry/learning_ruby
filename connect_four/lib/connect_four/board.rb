require_relative 'core_extensions'

class Board

	class Cell
		attr_accessor :value

		def initialize(value = "")
			@value = value
		end	
	end

	attr_reader :grid

	def initialize 
		@grid = Array.new(6) { Array.new(7)  { Cell.new } } 
	end

	def display_grid
		puts "1 - 2 - 3 - 4 - 5 - 6 - 7"
	   @grid.each do |row|
	    puts row.map { |cell| cell.value.empty? ? "__" : "#{cell.value} " }.join("  ")
	  end
	end

	def get_cell(x, y)
	  @grid[y][x]
	end

	def set_cell(x,y, value)
	 	get_cell(x,y).value = value
	end

	def get_last_cell(col_num)
		case col_num 
	 	when 1 then get_cell(0,5)
	  when 2 then get_cell(1,5)
	  when 3 then get_cell(2,5)
	  when 4 then get_cell(3,5)
	  when 5 then get_cell(4,5)	
	  when 6 then get_cell(5,5)
	  when 7 then get_cell(6,5)
	  else
	  	"Invalid column number. Please try again!"
	  	get_last_cell(col_num = gets.chomp)
	  end
	end

	def get_last_empty_cell(col_num)
		column = @grid[col_num - 1]
		if !column[0].value.empty?
			return nil
		elsif column[5].value.empty?
			return get_last_cell(col_num)
		else
			column.each_with_index do |index, cell|
				if cell.value.empty?
					return get_cell(column, index)
				end
			end
		end

	end
	  
	def set_last_cell(col_num, value)	

	end
end
