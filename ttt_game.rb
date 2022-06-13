require 'pry-byebug'

class GameSetUp 
  @@games = 0
  @@num_of_players = 0
  @@someone_is_first = false
  @@pieces = ['X', 'O']
  @@board = [
    ["_.","_.","_."],
    ["_.","_.","_."],
    ["_.","_.","_."]
  ]

  attr_accessor :board

  def self.start_game
    puts "Let's play Tic Tac Toe!"
    @@games +=1
  end

  def self.puts_board
    puts @@board[0][0..2].join
    puts @@board[1][0..2].join
    puts @@board[2][0..2].join
  end

  def initialize
  end
end 

class GamePlay < GameSetUp
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

  def take_turn
    puts "#{@name}, where would you like to put your #{@piece}?"
    puts "Row: 1, 2, or 3?"
    row = gets.chomp.to_i - 1 
    puts "Column: 1, 2, or 3?"
    column = gets.chomp.to_i - 1
    @@board[row][column] = ""
    @@board[row][column] = "#{@piece}"
    @num_of_turns -= 1
  end
end

class GameWin < GameSetUp

  @@win = ''
  def initialize
  end
  

  def self.check_for_win
    @@checking = @@board.flatten
    if @@checking[0..2] == "XXX" || @@checking[3..5] == "XXX" || @@checking[6..8] == "XXX"
      puts "X wins!"
    elsif @@checking[0] == "X" && @@checking[3] == "X" && @@checking[6] == "X"
      puts "X wins!"
    elsif @@checking[1] == "X" && @@checking[4] == "X" && @@checking[7] == "X" 
      puts "X wins!"  
    elsif @@checking[2] == "X" && @@checking[5] == "X" && @@checking[8] == "X"   
      puts "X wins" 
    elsif @@checking[0] == "X" && @@checking[4] == "X" && @@checking[8] == "X"   
      puts "X wins"
    elsif @@checking[6] == "X" && @@checking[4] == "X" && @@checking[2] == "X"
      puts "X wins"
    elsif @@checking[0..2] == "OOO" || @@checking[3..5] == "OOO" || @@checking[6..8] == "OOO"
      puts "O wins!"
    elsif @@checking[0] == "O" && @@checking[3] == "O" && @@checking[6] == "O"
      puts "O wins!"
    elsif @@checking[1] == "O" && @@checking[4] == "O" && @@checking[7] == "O" 
      puts "O wins!"  
    elsif @@checking[2] == "O" && @@checking[5] == "O" && @@checking[8] == "O"   
      puts "O wins" 
    elsif @@checking[0] == "O" && @@checking[4] == "O" && @@checking[8] == "O"   
      puts "O wins"
    elsif @@checking[6] == "O" && @@checking[4] == "O" && @@checking[2] == "O"
      puts "O wins"  
    end  
  end
  
end

player1 = GamePlay.new
player2 = GamePlay.new
puts player1.info
puts player2.info
puts "Here is the board:\n"
GameSetUp.puts_board
player1.take_turn
GameSetUp.puts_board
player2.take_turn
GameSetUp.puts_board
player1.take_turn
GameSetUp.puts_board
player2.take_turn
GameSetUp.puts_board
player1.take_turn
GameSetUp.puts_board
binding.pry
GameWin.check_for_win