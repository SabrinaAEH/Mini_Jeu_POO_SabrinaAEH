require 'pry'

class Player
    attr_accessor :name, :life_points
  
    def initialize(name, life_points)
      @name = name
      @life_points = life_points.to_i
    end

    def show_state
        puts "#{@name} a #{@life_points} points de vie"
    end

    def gets_damage(damage)
        @life_points = @life_points - damage
        if @life_points <= 0
          puts "le joueur #{@name} a été tué !"
        end
    end

    def attacks(player)
        damage = compute_damage
        puts "#{@name} attaque #{player.name} et lui inflige #{damage} points de dommages."
        player.gets_damage(damage)
    end
    
    private
    
    def compute_damage
        rand(1..6)
    end
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name)
        @weapon_level = 1
        super(name,100)
    end

    def show_state
        puts "#{@name} a #{@life_points} points de vie, et une arme de niveau #{@weapon_level}"
    end

    def compute_damage
        rand(1..6) * @weapon_level
    end

    def search_weapon
        new_weapon_level = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    
        if new_weapon_level > @weapon_level
          @weapon_level = new_weapon_level
          puts "Youhou ! Elle est meilleure que ton arme actuelle : tu la prends 👍 "
        else
          puts "M@*#$... elle n'est pas mieux que ton arme actuelle... 👎 "
        end
    end

    def search_health_pack
        roll = rand(1..6)
        
        case roll
        when 1
          "Tu n'as rien trouvé... 😭 "
        when 2..5
          if @life_points + 50 <= 100 # vérifie que les points de vie ne dépasse pas 100, 
            @life_points += 50        # lifepoints <= 100, on peut ajouter 50
          else
            @life_points = 100        # mais en ne dépassant jamais 100
          end
           "Bravo, tu as trouvé un pack de +50 points de vie ! 🥳 "
        when 6
          if @life_points + 80 <= 100
            @life_points += 80
          else
            @life_points = 100
          end
            "Wow, tu as trouvé un pack de +80 points de vie ! 🤩 "
        end
    end

end

