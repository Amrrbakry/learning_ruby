require 'spec_helper'

describe Player do
	context "#initialize" do
		it "initializes the player with a name and a color" do
			player = Player.new("Amr", "blue")
			expect(player).to be_instance_of Player
			expect(player.name).to eql("Amr")
			expect(player.color).to eql("blue")
		end
	end

end