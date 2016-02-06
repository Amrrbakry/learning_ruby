require_relative "../lib/tic_tac_toe.rb"

puts "Welcome to Tic Tac Toe"
amr = TicTacToe::Player.new({name: "Amr", color: "X"})
amro = TicTacToe::Player.new({name: "Amro", color: "O"})
players = [amr, amro]
TicTacToe::Game.new(players).play