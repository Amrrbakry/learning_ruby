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
		puts "  1   -   2   -   3   -   4   -   5   -   6   -   7  "
	   @grid.each do |row|
	    puts row.map { |cell| cell.value.empty? ? "_____" : "#{cell.value.ljust(19)}" }.join("   ")
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
	  	nil
	  end
	end

	def get_last_empty_cell(col_num)
		column = @grid.transpose[col_num.to_i - 1]

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

	def game_over
		return :winner if winner? 
		return :draw if draw?
		false
	end

	def consecutive_four_cells(array)
 		result = []

 		array.flatten(1).each_cons(4) { |arr| result << arr }
 		result
 	end

	private


  def winning_positions
 		consecutive_four_cells(@grid) + # rows
 	  consecutive_four_cells(@grid.transpose) + # columns
 	  consecutive_four_cells(diagonals) # diagonals
 	end

 	public

 	def diagonals 
 	  [
 	  	[get_cell(0,5), get_cell(1,4), get_cell(2,3), get_cell(3,2), get_cell(4,1), get_cell(5,0)],
 	  	[get_cell(1,5), get_cell(2,4), get_cell(3,3), get_cell(4,2), get_cell(5,1), get_cell(6,0)],
 	  	[get_cell(2,5), get_cell(3,4), get_cell(4,3), get_cell(5,2), get_cell(6,1)],
 	  	[get_cell(3,5), get_cell(4,4), get_cell(5,3), get_cell(6,2)],

 	  	[get_cell(6,5), get_cell(5,4), get_cell(4,3), get_cell(3,2), get_cell(2,1), get_cell(1,0)],
 	  	[get_cell(5,5), get_cell(4,4), get_cell(3,3), get_cell(2,2), get_cell(1,1), get_cell(0,0)],
 	  	[get_cell(4,5), get_cell(3,4), get_cell(2,3), get_cell(1,2), get_cell(0,1)],
 	  	[get_cell(3,5), get_cell(2,4), get_cell(1,3), get_cell(0,2)]
 	  ]
 	end

 	private

 	def draw?
 	  @grid.flatten.map { |cell| cell.value }.none_empty?
 	end

 	def winner?
 	  winning_positions.each do |winning_position_array|
 	  		next if winning_position_values(winning_position_array).all_empty?
 	  		return true if winning_position_values(winning_position_array).all_same?
 	  end
 	  false
 	end

 	def winning_position_values(winning_position)
 	  winning_position.map { |cell| cell.value }
 	end

end


