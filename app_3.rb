require 'dotenv'
dotenv.load
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "\nQuel est ton prénom?"
name = gets.chomp

my_game = Game.new(name)

while my_game.is_still_ongoing?
  my_game.show_players
  my_game.menu
  puts "Entrez votre choix :"
  print "> "
  choice = gets.chomp
  my_game.menu_choice(choice)
  my_game.enemies_attack
end

my_game.end