require 'pry'
require_relative 'player'

class Game
  attr_accessor :human_player, :enemieS

  def initialize(human_player_name) # création des joueurs
    @enemieS=[]
    @human_player = HumanPlayer.new(human_player_name) # joueur utilisateur
    for i in 0..3
      @enemieS.push(Player.new("playeur#{i}")) # adversaire du joueur utilisateur
    end
  end

  def kill_player
    @enemieS.delete_if { |enemy| enemy.life_points <= 0 } # supprime un adversaire tué du groupe d'adversaires
  end

  def is_still_ongoing?
    human_player.life_points >0 && @enemieS.size >0 # reste il le joueur utilisateur et au moins un combatant
  end

  def show_players # point d'état
    puts "Point du combat :"
    human_player.show_state
    puts "Il reste #{enemieS.size} combatant(s) à tuer"
    puts
  end

  # déroulement du menu
  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts
    puts "attaquer un joueur en vue :"
    @enemieS.each_with_index {|enemy, i|
      print "#{i} - "
      enemy.show_state
    }
    print ">"
  end

  # déroulement suite au choix
  def menu_choice(choice)
    choice = choice.to_i if choice == "0" || choice == "1" ||choice == "2" || choice == "3"
    case choice
      when "a"
        human_player.search_weapon
      when "s"
        human_player.search_health_pack
      when 0..3
        human_player.attacks(@enemieS[choice])
        kill_player
      else
        puts "je n'ai pas compris"
        return "?"
    end
  end

  # gestion des attaques
  def enemies_attack
    if @enemieS.size >0 && human_player.life_points >0
      puts "-----------######-----------"
      puts "Les autres joueurs t'attaquent !"
      puts
      @enemieS.each {|enemie|
      enemie.attacks(human_player) if enemie.life_points >0 && human_player.life_points >0
      puts "------#------"
      }
    end
  end

  # déroulement de fin
  def end
    puts "La partie est finie"
    if human_player.life_points >0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end
end