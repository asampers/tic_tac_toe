module Winning

  COMBOS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

end

class Game 

  attr_reader :board, :current_player_id, :players

  def initialize
    @board = Array.new(10)
    @current_player_id = 0
    puts "Player One:"
    @players = [Player.new(self, "X")]
    puts "Thank you."
    puts "Player Two:"
    @players << Player.new(self, "O")
    puts "#{current_player} goes first."
  end

  def play
    loop do
      place_player_marker(current_player)

      if player_has_won?(current_player)
        puts "#{current_player} wins!"
        print_board()
        return
      else board_full?
        puts "It's a draw."
        print_board()
        return
      end

      switch_players!()
    end
  end        

  def free_positions
    (1..9).select {|position| @board[position].nil?}
  end
  
  def place_player_marker(player)
    position = player.select_position!
    puts "#{player} selects #{player.piece} position #{position}."
    @board[position] = player.piece
  end

  def player_has_won?(player)
    COMBOS.any? do |line|
      line.all? {|position| @board[position] == player.piece}
    end  
  end

  def board_full?
    free_positions.empty?
  end

  def current_player
    @players[current_player_id]
  end

  def other_player_id
    1 - @current_player_id
  end

  def opponent
    @players[other_player_id]
  end

  def switch_players!
    @current_player_id = other_player_id()
  end

  def turn_num
    10 - free_positions.size
  end

  def print_board
    col_separator, row_separator = " | ", "---------"
    label_for_position = lambda{|position| @board[position] ? @board[position] : position}
    
    row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
    row_positions = [[1,2,3], [4,5,6], [7,8,9]]
    rows_for_display = row_positions.map(&row_for_display)
    puts rows_for_display.join("\n" + row_separator + "\n")
  end
  
end 

class Player
  
  attr_reader :piece

  def initialize(game, piece)
    @game = game
    @piece = piece
    @name = get_player_name()
  end

  def get_player_name
      puts "Please enter your name."
      name = gets.chomp  
  end

  def select_position!
    @game.print_board
    loop do
      print "Select your #{piece} position: "
      selection = gets.to_i
      return selection if @game.free_positions.include?(selection)
      puts "Position #{selection} is not available. Try again."
    end  
  end

  def to_s
    "#{@name}"
  end
  
end

