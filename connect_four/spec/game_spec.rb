require "spec_helper"
describe Game do
	
	let(:amr) { Player.new("Amr", "blue") }
	let (:amro) { Player.new("Amro", "red") }
	let(:game) { Game.new }

	context "#initialize" do
		it "initializes the game board" do 
			expect(game.board).to be_instance_of Board
		end

		it "randomly selects a current player" do 
			allow_any_instance_of(Array).to receive(:shuffle) { [amr, amro] }.and_return(amro)
			expect(game.current_player).to eql amro
		end

		it "randomly selects the other player" do 
			allow_any_instance_of(Array).to receive(:shuffle) { [amr, amro] }.and_return(amr)
			expect(game.current_player).to eql amr
		end
	end

	context "#swap_players" do

		it "sets @current_player to @other_player" do
			other_player = game.other_player
			game.swap_players
			expect(game.current_player).to be other_player
		end

		it "sets @current_player to @other_player" do
			current_player = game.current_player
			game.swap_players
			expect(game.other_player).to be current_player
		end

	end	

  context "#game_over_message" do
  	it "returns '{current player name} won!' if board shows a winner" do
      allow(game).to receive(:current_player) { amr }
      allow(game.board).to receive(:game_over) { :winner }
      expect(game.game_over_message).to eql "Amr #{amr.color} won!"
    end
 
  	it "returns 'The game ended in a draw.' if board shows a draw" do
      allow(game).to receive(:current_player) { amro }
      allow(game.board).to receive(:game_over) { :draw }
      expect(game.game_over_message).to eql "The game ended in a draw."
    end
  end
end