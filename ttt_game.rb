class GameSetUp 
  @@games = 0
  @@num_of_players = 0
  @@someone_is_first = false
  @@pieces = ['X', 'O']
  
  attr_accessor :board

  def self.start_game
    puts "Let's play Tic Tac Toe!"
    @@games +=1
  end

  def initialize
    @board = [
    ["[]","[]","[]"].join,
    ["[]","[]","[]"].join,
    ["[]","[]","[]"].join
  ]
  end
end 

class Player < GameSetUp
  @@player1_turns = 0
  @@player2_turns = 0

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
          @@player1_turns = 5
          @num_of_turns = @@player1_turns
          @@someone_is_first = true
        elsif answer == 'n' && @@num_of_players == 1
          puts "That's okay. You don't have to."
          @@player1_turns = 4
          @num_of_turns = @@player1_turns
        else answer == 'n' && @@num_of_players == 2
          puts "Well, someone has to. so it's you!"
          @@player2_turns = 5
          @num_of_turns = @@player2_turns
        end
    else @@someone_is_first == true
      puts "You'll go second."
      @@player2_turns = 4
      @num_of_turns = @@player2_turns
    end 
  end

  def piece_selection
    if @@num_of_players == 1
      puts "Would you like to be the 'X' or the 'O'?"
      answer = gets.chomp.upcase
      if answer == 'X'
        @piece = @@pieces.shift
      else 
        @piece = @@pieces.pop
      end
    else 
      puts "You'll be the #{@@pieces[0]}."
      @piece = @@pieces.pop
    end  
  end

  def info
    "My name is #{@name}, I have #{@num_of_turns} turns left, and my piece is the #{@piece}."
  end

  def player1_take_turn
    puts "#{player1.name}, where would you like to put your #{player1.piece}?"
    puts "Row: "
    row = gets.chomp.to_i
    puts "Column: "
    column = gets.chomp.to_i
    board.board[row-1][column-1] = "#{player1.piece} "
    player1.num_of_turns -= 1
  end

  def player2_take_turn
    puts "#{player2.name}, where would you like to put your #{player2.piece}?" 
    puts "Row: 1, 2, or 3?"
    row = gets.chomp.to_i
    puts "Column: 1, 2, or 3?"
    column = gets.chomp.to_i
    board.board[row-1][column-1] = "#{player2.piece} "
    player2.num_of_turns -= 1
  end
end

class GamePlay < Player

  @@win = ''
  def initialize
  end

  def play_a_round
    if @@player1_turns != 0
      player1_take_turn
    end
    if @@player2_turns != 0
      player2_take_turn
    end
  end
  

  def check_for_win
    if board.board[0..2][0..2] == player1.piece
      @@win = "Congratulations, #{player1.name}! You won!"
    end  
  end
  
end

player1 = Player.new
player2 = Player.new
puts player1.info
puts player2.info
board = GameSetUp.new
puts "Here is the board:\n"
puts board.board
game = GamePlay.new
game.play_a_round
puts board.board
