#board = [
#  [o,o,o]
#  [x,o,x]
#  [o,x,x]
#  ]

class GameSetUp 
  @@games = 0
  @@num_of_players = 0
  @@someone_is_first = false
  @@pieces = ['x', 'o']
  
  def self.start_game
    puts "Let's play Tic Tac Toe!"
    @@games +=1
  end
end 

class Player < GameSetUp
  attr_accessor :name, :num_of_turns, :piece
  
  def initialize
    if @@num_of_players == 0
      GameSetUp.start_game
    end 
    get_player_name
    player_order
    piece_selection
  end

  def get_player_name
    if @@num_of_players == 0
      puts "Please enter the name of Player 1"
      @name = gets.chomp
      @@num_of_players +=1
    else 
      puts "Now enter the name of Player 2"
      @name = gets.chomp
      @@num_of_players +=1
    end
  end

  def player_order
    if @@someone_is_first == false
      puts "Would you like to go first? Y / N"
      answer = gets.chomp.downcase
        if answer == "y" && @@num_of_players == 1
          puts "Great."
          @num_of_turns = 5
          @@someone_is_first = true
        elsif answer == 'n' && @@num_of_players == 1
          puts "That's okay. You don't have to."
          @num_of_turns = 4
        else answer == 'n' && @@num_of_players == 2
          puts "Well, someone has to. so it's you!"
          @num_of_turns = 5
        end
    else @@someone_is_first == true
      puts "Your opponent already chose to go first, so you'll go second."
      @num_of_turns = 4
    end 
  end

  def piece_selection
    if @@num_of_players == 1
      puts "Would you like to be the 'X' or the 'O'?"
      answer = gets.chomp.downcase
      if answer == 'x'
        @piece = @@pieces.shift
      else 
        @piece = @@pieces.pop
      end
    else 
      puts "Your opponent already chose their piece so you have to be the #{@@pieces[0].upcase}."
      @piece = @@pieces.pop
    end  
  end

  def info
    "My name is #{@name}, I have #{@num_of_turns} turns left, and my piece is the #{@piece.upcase}."
  end
  
end

player1 = Player.new
player2 = Player.new
puts player1.info
puts player2.info