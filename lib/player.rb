require_relative 'game.rb'

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