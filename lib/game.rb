require 'pry'

require_relative 'player'

class Game < HumanPlayer
  attr_accessor :human_player, :enemies

  def initialize(name)
    @human_player = HumanPlayer.new(name)       # méthode de définition du HumanPlayer et des 4 ennemies
    enemy1 = Player.new("enemy1", 100)
    enemy2 = Player.new("enemy2", 100)
    enemy3 = Player.new("enemy3", 100)
    enemy4 = Player.new("enemy4", 100)
    @enemies = [enemy1, enemy2, enemy3, enemy4]
  end

  def kill_player(player)                       # Méthode qui permet d'éliminer un adversaire tué, 
    @enemies.delete(player)                     # elle prend un player en entrée et le supprime de l'array ennemies qd il n'a plus de vies
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && !@enemies.empty? # méthode qui vérifie si mon humanplayer a tjs des vies et si l'array ennemies n'est pas vide
  end

  def show_players
    puts @human_player.show_state
    puts "Il reste #{@enemies.length} ennemis en jeu 😈 "
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"
    @enemies.each_with_index do |enemy, index|
      puts "#{index} - #{enemy.show_state}" if enemy.life_points > 0
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      result = @human_player.search_weapon
      puts result
    when "s"
      result = @human_player.search_health_pack
      puts result
    else
      if choice.to_i.to_s == choice && choice.to_i < @enemies.length
        @human_player.attacks(@enemies[choice.to_i])
        kill_player(@enemies[choice.to_i]) if @enemies[choice.to_i].life_points <= 0
      else
        puts "Commande invalide 🚫 "
      end
    end
  end

  def enemies_attack
    @enemies.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(@human_player)
      end
    end
  end

  def end
    puts "La partie est finie!"
    if @human_player.life_points > 0
      puts "Bravo, tu as gagné! 🎉 "
    else
      puts "It's over, Loser! 😵 "
    end
  end
end
