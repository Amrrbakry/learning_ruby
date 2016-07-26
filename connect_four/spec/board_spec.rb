require './lib/connect_four/board.rb'

describe Board do

	let(:board) { Board.new }
		
	context "#initialzie" do
		it "initialzies the board with a grid" do
			expect { board }.to_not raise_error
		end
			
		it "sets the grid with 6 rows by default" do
			expect(board.grid.size).to eql(6)
		end

		it "sets the grid with 7 columns by default" do
			expect(board.grid.transpose.size).to eql(7)
		end

	end

	context "#get_cell" do
		it "returns the cell value based on the (x,y) coordinate" do
			board.grid[1][1] = "yellow"
			expect(board.get_cell(1,1)).to eql("yellow")
		end
	end

	context "#set_cell" do
		it "sets the cell with the given value" do
			board.set_cell(1,1, "yellow")
			expect(board.grid[1][1].value).to eql("yellow")
		end
	end

	context "#get_last_cell" do
		it "returns the value of the last cell in a given column" do
			board.set_last_cell(4, "red")
			expect(board.get_last_cell(4).value).to eql("red")
		end
	end

	context "#get_last_empty_cell" do
		
		it "returns the last empty cell in the column" do
			expect(board.get_last_empty_cell(4)).to eql(board.get_cell(3,5))
		end		

		it "returns the last empty cell in the column" do
			board.set_cell(1,5, "r")
			board.set_cell(1,4, "y")
			board.set_cell(1,3, "y")
			board.set_cell(1,2, "y")
			board.set_cell(1,1, "y")
			expect(board.get_last_empty_cell(2)).to eql(board.get_cell(1,0))
		end

		it "returns nil if there are no empty cells in the column" do
			board.set_cell(0,5, "r")
			board.set_cell(0,4, "r")
			board.set_cell(0,3, "r")
			board.set_cell(0,2, "r")
			board.set_cell(0,1, "r")
			board.set_cell(0,0, "r")
			expect(board.get_last_empty_cell(1)).to be nil
		end

	end

	context "#set_last_cell" do
			
		context "last cell in column is empty" do
			it "sets the last cell in a given column with value" do
				board.set_last_cell(1, "yellow")
				expect(board.get_cell(0,5).value).to eql("yellow")
			end

			it "sets the last cell in a given column with value" do
				board.set_last_cell(5, "yellow")
				expect(board.get_cell(4,5).value).to eql("yellow")
			end
		end

		context "last cell in column is not empty" do

			it "doesn't set the last cell in a given column with value" do
				board.set_last_cell(1, "yellow")
				expect(board.get_cell(0,5).value).to_not be_empty 
				board.set_last_cell(1, "red")
				expect(board.get_cell(0,5).value).to eql("yellow")
			end

			it "finds the last empty cell in the column and set it equal to value" do
				board.set_last_cell(1, "red")
				expect(board.get_cell(0,5).value).to_not be_empty 
				board.set_last_cell(1, "yellow")
				expect(board.get_cell(0,4).value).to eql("yellow")
			end
		end
	end

	context "#consecutive_four_cells" do
		it "returns every consecutive four cells in a row of the grid" do
			four_cons_cells_arr = [
				[board.get_cell(0,0), board.get_cell(1,0), board.get_cell(2,0), board.get_cell(3,0)],
				[board.get_cell(1,0), board.get_cell(2,0), board.get_cell(3,0), board.get_cell(4,0)],
				[board.get_cell(2,0), board.get_cell(3,0), board.get_cell(4,0), board.get_cell(5,0)],
				[board.get_cell(3,0), board.get_cell(4,0), board.get_cell(5,0), board.get_cell(6,0)]
			]

			expect(board.consecutive_four_cells(board.grid[0])).to eql(four_cons_cells_arr)
		end

		it "returns every consecutive four cells in a column of the grid" do
			four_cons_cells_arr = [
				[board.get_cell(0,0), board.get_cell(0,1), board.get_cell(0,2), board.get_cell(0,3)],
				[board.get_cell(0,1), board.get_cell(0,2), board.get_cell(0,3), board.get_cell(0,4)],
				[board.get_cell(0,2), board.get_cell(0,3), board.get_cell(0,4), board.get_cell(0,5)]
			]

			expect(board.consecutive_four_cells(board.grid.transpose[0])).to eql(four_cons_cells_arr)
		end

		it "returns every consecutive four cells in a diagonal" do
			four_cons_cells_arr = [
				[board.get_cell(0,5), board.get_cell(1,4), board.get_cell(2,3), board.get_cell(3,2)],
				[board.get_cell(1,4), board.get_cell(2,3), board.get_cell(3,2), board.get_cell(4,1)],
				[board.get_cell(2,3), board.get_cell(3,2), board.get_cell(4,1), board.get_cell(5,0)]
			]

			expect(board.consecutive_four_cells(board.diagonals[0])).to eql (four_cons_cells_arr)
		end 
	end

	TestCell = Struct.new(:value)
	let(:x_cell) { TestCell.new("X") }
	let(:y_cell) { TestCell.new("Y") }
	let(:empty) { TestCell.new }

	context "#game_over" do
  	it "returns :winner if winner? is true" do
    	allow(board).to receive(:winner?) { true }
    	expect(board.game_over).to eq :winner
  	end

  	it "returns :draw if winner? is false and draw? is true" do
    	allow(board).to receive(:winner?) { false }
    	allow(board).to receive(:draw?) { true }
    	expect(board.game_over).to eq :draw
  	end

  	it "returns false if winner? is false and draw? is false" do
    	allow(board).to receive(:winner?) { false }
    	allow(board).to receive(:draw?) { false }
    	expect(board.game_over).to be_falsey
  	end

  	it "returns :winner when row has objects with values that are all the same" do
   		board.set_cell(2,0, x_cell)
   		board.set_cell(3,0, x_cell)
   		board.set_cell(4,0, x_cell)
   		board.set_cell(5,0, x_cell)
    	expect(board.game_over).to eql :winner
  	end

  	it "returns :winner when colum has objects with values that are all the same" do
  		board.set_cell(3,1, y_cell)
  		board.set_cell(3,2, y_cell)
  		board.set_cell(3,3, y_cell)
  		board.set_cell(3,4, y_cell)
    	expect(board.game_over).to eql :winner
  	end

  	it "returns :winner when diagonal has objects with values that are all the same" do
  		board.set_cell(5,5, x_cell)
  		board.set_cell(4,4, x_cell)
  		board.set_cell(3,3, x_cell)
  		board.set_cell(2,2, x_cell)
    	expect(board.game_over).to eql :winner
  	end

  	xit "returns :draw when all spaces on the board are taken" do

    	expect(board.game_over).to eq :draw
  	end

  	it "returns false when there is no winner or draw" do
  		board.set_cell(5,2, x_cell)
  		board.set_cell(0,5, y_cell)
  		board.set_cell(6,3, x_cell)
  		board.set_cell(1,2, x_cell)
    	expect(board.game_over).to be_falsey
  	end
	end
end



