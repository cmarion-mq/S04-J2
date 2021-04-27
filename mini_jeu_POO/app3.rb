require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "------------------------------------------------"

# Création du joueur de l'utilsateur et des ennemis
puts "Comment veux tu t'appeler?"
print ">"
human_player_name = gets.chomp
my_game = Game.new(human_player_name)

# Déroulement du jeu
while my_game.is_still_ongoing? == true #on vérifie qu'il y a bien aux moins deux adversaires
  puts
  my_game.show_players
  puts "------------####------------"
  my_game.menu
  choice = gets.chomp
  while my_game.menu_choice(choice) == "?"
    puts
    my_game.menu
    choice = gets.chomp
    my_game.menu_choice(choice)
  end
  puts
  my_game.enemies_attack
  puts "------------####------------"

end  
my_game.end