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
		xit "returns the value of the last cell in a given column" do
			board.set_last_cell(4, "red")
			expect(board.get_last_cell(4).value).to eql("red")
		end
	end

	context "#get_last_empty_cell" do
		
		it "returns the last empty cell in the colum" do
			expect(board.get_last_empty_cell(1)).to eql(board.get_cell(0,5))
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

		it "returns the last empty cell in the colum" do
			board.set_cell(0,5, "r")
			board.set_cell(0,4, "ss")
			expect(board.get_last_empty_cell(1)).to eql(board.get_cell(0,3))
		end

	end

	context "#set_last_cell" do
			
		context "last cell in column is empty" do
			xit "sets the last cell in a given column with value" do
				board.set_last_cell(1, "yellow")
				expect(board.get_cell(0,5).value).to eql("yellow")
			end

			xit "sets the last cell in a given column with value" do
				board.set_last_cell(5, "yellow")
				expect(board.get_cell(4,5).value).to eql("yellow")
			end
		end

		context "last cell in column is not empty" do

			xit "doesn't set the last cell in a given column with value" do
				board.set_last_cell(1, "yellow")
				expect(board.get_cell(0,5).value).to_not be_empty 
				board.set_last_cell(1, "red")
				expect(board.get_cell(0,5).value).to eql("yellow")
			end

			xit "sets the cell above it in the column" do
				board.set_last_cell(1, "red")
				expect(board.get_cell(0,5).value).to_not be_empty 
				board.set_last_cell(1, "yellow")
				expect(board.get_cell(0,4).value).to eql("yellow")
			end
		end
	end

end



