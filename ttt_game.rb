class GameSetUp 
  
  @@games = 0
  @@num_of_players = 0
  @@someone_is_first = false
  @@total_turns = 9
  @@pieces = ['X', 'O']
  @@winner = 'false'
  @@board = [
    ["_ ","_ ","_ "],
    ["_ ","_ ","_ "],
    ["_ ","_ ","_ "]
  ]

  attr_accessor :board

  def initialize
  end

  def self.start_game
    puts "Let's play Tic Tac Toe!"
    @@games +=1
  end

  def self.puts_board
    puts @@board[0][0..2].join
    puts @@board[1][0..2].join
    puts @@board[2][0..2].join
  end

  def self.puts_board_flatten
    puts @@board.flatten[0..2]
  end

  def self.check_for_win
    @@checking = @@board.flatten
    if @@total_turns == 0
      puts "Game over. It's a tie."
    elsif @@checking[0..2].join == "XXX" || @@checking[3..5].join == "XXX" || @@checking[6..8].join == "XXX"
      puts "X wins!"
      @@total_turns = 0
      return
    elsif @@checking[0] == "X" && @@checking[3] == "X" && @@checking[6] == "X"
      puts "X wins!"
      @@total_turns = 0
      return
    elsif @@checking[1] == "X" && @@checking[4] == "X" && @@checking[7] == "X" 
      puts "X wins!" 
      @@total_turns = 0
      return
    elsif @@checking[2] == "X" && @@checking[5] == "X" && @@checking[8] == "X"   
      puts "X wins" 
      @@total_turns = 0
      return
    elsif @@checking[0] == "X" && @@checking[4] == "X" && @@checking[8] == "X"   
      puts "X wins"
      @@total_turns = 0
    elsif @@checking[6] == "X" && @@checking[4] == "X" && @@checking[2] == "X"
      puts "X wins"
      @@total_turns = 0
      return
    elsif @@checking[0..2].join == "OOO" || @@checking[3..5].join == "OOO" || @@checking[6..8].join == "OOO"
      puts "O wins!"
      @@total_turns = 0
      return
    elsif @@checking[0] == "O" && @@checking[3] == "O" && @@checking[6] == "O"
      puts "O wins!"
      @@total_turns = 0
      return
    elsif @@checking[1] == "O" && @@checking[4] == "O" && @@checking[7] == "O" 
      puts "O wins!"  
      @@total_turns = 0
      return
    elsif @@checking[2] == "O" && @@checking[5] == "O" && @@checking[8] == "O"   
      puts "O wins" 
      @@total_turns = 0
      return
    elsif @@checking[0] == "O" && @@checking[4] == "O" && @@checking[8] == "O"   
      puts "O wins"
      @@total_turns = 0
      return
    elsif @@checking[6] == "O" && @@checking[4] == "O" && @@checking[2] == "O"
      puts "O wins"  
      @@total_turns = 0 
      return 
    end  
  end
end 

class GamePlay < GameSetUp
  
  @@player1 = {
    name: "",
    piece: ""
  }

  @@player2 = {
    name: "",
    piece: ""
  }

  def initialize
    if @@num_of_players == 0
      GameSetUp.start_game
    end 
    get_player_name
    piece_selection
  end

  def get_player_name
    if @@num_of_players == 0
      puts "Please enter the name of Player 1"
      @@player1[:name] = gets.chomp
      @@num_of_players +=1
    else 
      puts "Now enter the name of Player 2"
      @@player2[:name] = gets.chomp
      @@num_of_players +=1
    end
  end

  def piece_selection
    if @@num_of_players == 1
      puts "Would you like to be the 'X' or the 'O'?"
      answer = gets.chomp.upcase
      if answer == 'X'
        @@player1[:piece] = @@pieces.shift
      else 
        @@player1[:piece] = @@pieces.pop
      end
    else 
      puts "#{@@player2[:name]} will be the #{@@pieces[0]}."
      @@player2[:piece] = @@pieces.pop
    end  
  end

  def self.player1_turn
    puts "#{@@player1[:name]}, where would you like to put your #{@@player1[:piece]}?"
    puts "Row: 1, 2, or 3?"
    row = gets.chomp.to_i - 1 
    puts "Column: 1, 2, or 3?"
    column = gets.chomp.to_i - 1
    @@board[row][column] = ""
    @@board[row][column] = "#{@@player1[:piece]}"
    puts "________"
    GameSetUp.puts_board
    GameSetUp.check_for_win
  end

  def self.player2_turn
    puts "#{@@player2[:name]}, where would you like to put your #{@@player2[:piece]}?"
    puts "Row: 1, 2, or 3?"
    row = gets.chomp.to_i - 1 
    puts "Column: 1, 2, or 3?"
    column = gets.chomp.to_i - 1
    @@board[row][column] = ""
    @@board[row][column] = "#{@@player2[:piece]}"
    puts "________"
    GameSetUp.puts_board
    GameSetUp.check_for_win
  end
  
  def self.play_round
    while @@total_turns >= 1
      player1_turn
      @@total_turns -= 1
      if @@total_turns >= 1
        player2_turn
        @@total_turns -= 1
      end   
    end          
  end

end


player1 = GamePlay.new
player2 = GamePlay.new
puts "Here is the board:\n"
GameSetUp.puts_board
GamePlay.play_round