require_relative "board"
require_relative "player"
require 'colorize'

class Game
	attr_reader :board, :players, :current_player, :other_player
	def initialize
		@board = Board.new
		@players = get_players_info
		@current_player, @other_player = @players.shuffle
	end

	def welcome_message 
		puts "WELCOME TO CONNECT FOUR!"
		puts "----------------------------------------"
		puts ""
	end
	
	def get_players_info
		players = []
		colors = ["red", "green", "blue", "black"] 
		2.times do |i|
			print "Player ##{i + 1} please enter your name: "
			name = gets.chomp
			puts "please choose a color"
			colors.each { |color| print "(#{color.colorize(color.to_sym)})"}
			puts ""
			color = gets.chomp
			if colors.include?(color)
				name = Player.new(name, color.colorize(color.to_sym))
				players << name
				colors.delete(color)
				puts "#{name.name} has color #{name.color}"
			else
				puts "invalid input!"
				color = colors.sample
				colors.delete(color)
				name = Player.new(name, color.colorize(color.to_sym))
				players << name
				puts "you've been assigned a random color! #{color.colorize(color.to_sym)}"
				puts "#{name.name} has color #{name.color.colorize(color.to_sym)}"
			end
		end
		players
	end

	def swap_players
		@current_player, @other_player = @other_player, @current_player
	end

  def game_over_message
  	return "#{current_player.name} #{current_player.color} won!" if board.game_over == :winner
  	return "The game ended in a draw." if board.game_over == :draw
  end

end

game = Game.new
