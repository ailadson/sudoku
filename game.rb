require "./board.rb"

class Game
  def initialize(file_name)
    @board = Board.from_file(file_name)
  end

  def play
    until @board.solved?
      @board.render
      make_move
    end

    @board.render
    puts "Congrats! You've won."
  end

  def make_move
    position = get_position
    value = get_value

    idx1, idx2 = position
    @board.grid[idx1][idx2].value = value
  end

  def get_value
    puts "What value?"

    val = gets.chomp.to_i

    while val > 9 || val < 1
      puts "Must be 1 - 9."
      print "What value? "
      val = gets.chomp.to_i
    end

    val.to_s
  end


  def get_position
    [get_dim("row"), get_dim("column")]
  end

  def get_dim(type)
    print "Which #{type}: "
    pos = gets.chomp.to_i

    while pos > 8
      puts "Out of bounds."
      print "Which #{type}: "
      pos = gets.chomp.to_i
    end

    pos
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new("sudoku1-almost.txt")
  g.play
end
