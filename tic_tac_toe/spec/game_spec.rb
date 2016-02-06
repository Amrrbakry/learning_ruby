require_relative "spec_helper"

module TicTacToe
  describe Game do

  	let (:amr) { Player.new({ name: "amr", color: "X" }) }
  	let (:amro) { Player.new({ name: "amro", color: "O" }) }

  	context "#initialize" do
  	  it "randomly selects a current player" do
  	  	Array.any_instance.stub(:shuffle) { [amr, amro] }
  	  	game = Game.new([amr, amro])
  	  	expect(game.current_player).to eq amro
  	  end

  	  it "randomly selects the other player" do
  	  	Array.any_instance.stub(:shuffle) { [amr, amro] }
  	  	game = Game.new([amr, amro])
  	  	expect(game.current_player).to eq amr
  	  end
  	end

  	context "#swap_players" do
  	  it "will set @current_player to @other_player" do
  	  	game = Game.new([amr, amro])
  	  	other_player = game.other_player
  	  	game.swap_players
  	  	expect(game.current_player).to eq other_player
  	  end

  	  it "will set @other_player to @current_player" do
  	  	game = Game.new([amr, amro])
  	  	currnet_player = game.current_player
  	  	game.swap_players
  	  	expect(game.other_player).to eq current_player
  	  end
  	end

  	context "#solicit_move" do
  	  it "asks the player to make a move" do
  	  	game = Game.new([amr, amro])
  	  	game.stub(:current_player) { amr }
  	  	expected = "amr: Enter a number from 1 to 9 to make your move"
  	  	expect(game.solicit_move).to eq expected
  	  end
  	end

  	context "#get_move" do
      it "converts human move of 1 to [0,0]" do
      	game = Game.new([amr, amro])
      	expect(game.get_move("1")).to eq [0,0]
      end

      it "converts human move of 7 to [0,2]" do
      	game = Game.new([amr, amro])
      	expect(game.get_move("7")).to eq [0,2]
      end
  	end

  context "#game_over_message" do
  	it "returns '{current player name} won!' if board shows a winner" do
      game = Game.new([bob, frank])
      game.stub(:current_player) { bob }
      game.board.stub(:game_over) { :winner }
      expect(game.game_over_message).to eq "bob won!"
    end
 
    it "returns 'The game ended in a tie' if board shows a draw" do
      game = Game.new([bob, frank])
      game.stub(:current_player) { bob }
      game.board.stub(:game_over) { :draw }
      expect(game.game_over_message).to eq "The game ended in a tie"
    end
  end
 end
end