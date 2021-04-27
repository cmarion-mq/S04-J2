require 'bundler'
Bundler.require

#require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "------------------------------------------------"

@enemieS=[]

# Création du joueur de l'utilsateur
def human_player_create
  puts "Comment veux tu t'appeler?"
  print ">"
  human_player_name = gets.chomp
  human_player = HumanPlayer.new(human_player_name)
  return human_player
end

# Création des ennemis
def create_enemies(player_number,player_name)
  player_number = Player.new(player_name)
  @enemieS.push(player_number)
  return @enemieS
end

# Déroulement du jeu
def let_s_fight(user)
  while user.life_points >0 && (@enemieS[0].life_points >0 || @enemieS[1].life_points >0) #on vérifie qu'il y a bien aux moins deux adversaires
    puts "Voici l'état de ton joueur :"
    user.show_state
    
    puts
    puts "-----------######-----------"
    # Menu
    n=0
    until n>0 # boucle qui permet de relancer le menu en cas de saisie invalide
      puts "Quelle action veux-tu effectuer ?"
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner"
      puts "attaquer un joueur en vue :"
      @enemieS.each_with_index {|enemy, i|
        print "#{i} - "
        enemy.show_state
      }
      print ">"
      choice = gets.chomp
      puts

    # Action en fonction du choix de l'utilisateur
      case choice
        when "a"
          user.search_weapon
          n=1
        when "s"
          user.search_health_pack
          n=1
        when "0"
          user.attacks(@enemieS[0])
          n=1
        when "1"
          user.attacks(@enemieS[1])
          n=1
        else
          puts "je n'ai pas compris"
          puts
      end
    end
    break if user.life_points <0 || (@enemieS[0].life_points <0 && @enemieS[1].life_points <0) #on vérifie qu'il y a bien aux moins deux adversaires
    puts
    puts "-----------######-----------"
    puts "Les autres joueurs t'attaquent !"
    @enemieS.each {|enemie|
    enemie.attacks(user) if enemie.life_points >0
    puts "------#------"
    puts
    }
    break if user.life_points <0 || (@enemieS[0].life_points <0 && @enemieS[1].life_points <0) #on vérifie qu'il y a bien aux moins deux adversaires
  end

  # Déroulement de la fin de partie
  puts
  puts "La partie est finie"
  if user.life_points >0
    puts "BRAVO ! TU AS GAGNE !"
  else
    puts "Loser ! Tu as perdu !"
  end
end

def perform
  human_player = human_player_create
  enemieS = create_enemies("player1","Josiane")
  enemieS = create_enemies("player2", "José")
  puts
  let_s_fight(human_player)
end

perform