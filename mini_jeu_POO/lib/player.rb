require 'pry'

class Player
  attr_accessor :name, :life_points

  def initialize(name_to_save) #sert uniquement aux ennemis, voir class HumanPlayer pour celle du joueur
    @name = name_to_save
    @life_points = 10
  end

  # point d'état
  def show_state
    if @life_points<=0
      puts "#{@name} a été tué"
    else
      puts "#{@name} a #{@life_points} points de vie"
    end
  end

  # Un joueur a-t-il été tué?
  def gets_damage(life_points_to_take)
    @life_points -= life_points_to_take
    puts "le joueur #{@name} a été tué !" if @life_points <= 0
  end

  # déroulement des attaques, en fonction du dommage
  def attacks(player_attacked) 
    puts "le joueur #{@name} attaque le joueur #{player_attacked.name}"
    damage = compute_damage
    puts "il lui inflige #{damage} points de dommages"
    player_attacked.gets_damage(damage)
  end

  # dommage des attaques
  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player # cette class sert à la gestion du joueur créé par l'utilisateur
  attr_accessor :weapon_level

  def initialize(name_to_save) # initialisation => + de life_points et ajout d'une arme d'un niveau qui évolue
    @life_points = 100
    @weapon_level = 1
    super(name_to_save)
  end

  def show_state # plus précis que celui de la class Player, weapon_level
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage # tiens compte du weapon_level
    rand(1..6) * @weapon_level
  end

  # gestion du weapon_level
  def search_weapon
    weapon_level_find = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{weapon_level_find}"
    if weapon_level_find > @weapon_level
      @weapon_level = weapon_level_find
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  # gestion du life_points
  def search_health_pack
    health_pack_find = rand(1..6)
    case  health_pack_find
      when 1
        puts "Tu n'as rien trouvé..."
      when 2 .. 5
        puts "Bravo, tu as trouvé un pack de +50 points de vie !"
        @life_points + 50 >= 100 ? @life_points = 100 : @life_points += 50
      else
        puts "Bravo, tu as trouvé un pack de +80 points de vie !"
        @life_points + 80 >= 100 ? @life_points = 100 : @life_points += 80  
    end
  end
end