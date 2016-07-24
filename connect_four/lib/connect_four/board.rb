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
		column = @grid.transpose[col_num - 1]

		column.reverse_each do |cell|
			if cell.value.empty?
					return cell
			elsif !cell.value.empty?
				next
			end	
		end

		if column.none_empty?
			return nil
		end	
	end
	  
	def set_last_cell(col_num, value)	
		get_last_empty_cell(col_num).value = value
	end
end



