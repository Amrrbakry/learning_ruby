require_relative "spec_helper"

module TicTacToe
  describe Player do
  	context "#initialize" do

  	  it "raises an excpetion when initialized with {}" do
  	  	expect { Player.new({}) }.to raise_error(KeyError)
  	  end

  	  it "doesn't raise an error when initialized with a vaild input hash" do
  	  	input = { name: "Someone", color: "X" }
  	    expect { Player.new(input) }.to_not raise_error "ArgumentError"
  	  end
  	end

  	context "#name" do
  	  it "returns the player's name" do
  	  	input = { name: "Someone", color: "X" }
  	  	player = Player.new(input)
  	  	expect(player.name).to eq "Someone"
  	  end
  	end

  	context "#color" do
  	  it "returns the color" do
  	  	input = { name: "Someone", color: "X" }
  	  	player = Player.new(input)
  	  	expect(player.color).to eq "X"
  	  end
  	end
  end
end