require 'pry'
require_relative 'player'

class Game
  attr_accessor :human_player, :players_left, :enemieS_in_sight

  def initialize(human_player_name) # création des joueurs
    @players_left = 10
    @enemieS_in_sight=[]
    @human_player = HumanPlayer.new(human_player_name) # joueur utilisateur
    for i in 0..3
      @enemieS_in_sight.push(Player.new("playeur#{i}")) # adversaire du joueur utilisateur
    end
  end

  def kill_player
    @enemieS_in_sight.delete_if { |enemy| enemy.life_points <= 0 } # supprime un adversaire tué du groupe d'adversaires
  end

  def is_still_ongoing?
    human_player.life_points >0 && @enemieS_in_sight.size >0 # reste il le joueur utilisateur et au moins un combatant
  end

  def show_players # point d'état
    puts "Point du combat :"
    human_player.show_state
    puts "Il reste #{@enemieS_in_sight.size} combatant(s) à tuer"
  end

  # déroulement du menu
  def menu
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts
    puts "attaquer un joueur en vue :"
    @enemieS_in_sight.each_with_index {|enemy, i|
      print "#{i} - "
      enemy.show_state
    }
    print ">"
  end

  # déroulement suite au choix
  def menu_choice(choice)
    choice = choice.to_i if !(choice == "a" || choice == "s")
    case choice
      when "a"
        human_player.search_weapon
      when "s"
        human_player.search_health_pack
      when 0..10000
        human_player.attacks(@enemieS_in_sight[choice])
        kill_player
      else
        puts "je n'ai pas compris"
        return "?"
    end
  end

  # gestion des attaques
  def enemies_attack
    if @enemieS_in_sight.size >0 && human_player.life_points >0
      puts "-----------######-----------"
      puts "Les autres joueurs t'attaquent !"
      @enemieS_in_sight.each {|enemie|
      enemie.attacks(human_player) if enemie.life_points >0 && human_player.life_points >0
      puts "------#------"
      }
    end
  end

  # Ajout de nouveaux adversaires ou non
  def new_players_in_sight
    if @enemieS_in_sight.size >= @players_left.size
      puts "Tous les joueurs sont déjà en vue"
    else
      case rand(1..6)
        when 2..4
          @enemieS_in_sight.push(Player.new("playeur#{rand(1..10000)}"))
          puts "Un ennemi est rentré dans la partie"
        when 5..6
          2.times { @enemieS_in_sight.push(Player.new("playeur#{rand(1..10000)}")) }
          puts "Deux ennemis sont rentrés dans la partie"
        else
          puts "Pas de nouvel ennemi dans la partie"
      end
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