require 'dotenv'
dotenv.load
require 'bundler'
Bundler.require

require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "\nQuel est ton prénom?"
name = gets.chomp
user = HumanPlayer.new(name)

puts "Initialisation de tes ennemis 😈 :"
player1 = Player.new("Josiane", 100)
player2 = Player.new("José", 100)
ennemies = [player1, player2]
puts "#{player1.name} & #{player2.name}"

while user.life_points > 0 && player1.life_points > 0 && player2.life_points > 0 # ici, une première boucle while, tant que tout le monde est en vie, cad que j'arrête le jeu dès qu'un joueur n'a plus de pts de vie
    puts "\n#{user.show_state}"                                                  # ici, je mets où en est mon user
    
    valid_choice = false                                                         # puis je propose le menu
    while !valid_choice                                                          # je définis valid_choice comme false car au départ le user n'a pas fait de choix valide
      puts "\nQuelle action veux-tu effectuer ?"                                 # la boucle while continuera de s'exécuter tant que valid_choice est false cad tant que le user n'a pas fait un choix valide,
      puts "a - Chercher une meilleure arme"                                     # une fois que le user a fait un choix défini comme valide (les choix valide sont tout ceux ou je rajoute valid_choice = true),
      puts "s - Chercher à se soigner"                                           # le programme ira chercher la commande indiquée (attacks, health_pack,weapon,...)
      puts "Attaquer un joueur en vue :"
      puts "0 - #{player1.show_state}"
      puts "1 - #{player2.show_state}"
      print "> "
      choice = gets.chomp

      case choice
      when "a"
        result = user.search_weapon
        puts result
        valid_choice = true
      when "s"
        result = user.search_health_pack
        puts result
        valid_choice = true
      when "0"
        user.attacks(player1)
        valid_choice = true
      when "1"
        user.attacks(player2)
        valid_choice = true
      else
        puts "Commande invalide"
      end
    end

    puts "\nLes autres joueurs t'attaquent 🔫 !"
  
    ennemies.each do |ennemy|      # ici je parcoure mon array ennemies
      if ennemy.life_points > 0    # ici je vérifie à chaque tour de boucle que mon ennemi a tjs plus de 0 points de vie
        ennemy.attacks(user)       # si oui, alors il peut attaquer le user
      end
    end
end

def end_of_game(user)              # méthode de fin de jeu qui indique que la partie est finie
    puts "La partie est finie!"    
    if user.life_points > 0       
        puts "Bravo, tu as gagné! 🎉 "
    else puts "It's over, Loser! 😵 "
    end
end

end_of_game(user)