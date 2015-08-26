require "./tile.rb"
require "colorize"


class Board
  def self.from_file(file_name)
    grid = []
    File.open(file_name).each do |line|
      line_ar = []
      line.chomp.split("").each do |num|
        line_ar << Tile.new(num)
      end
      grid << line_ar
    end

    Board.new(grid)
  end

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def render
    system("clear")
    @grid.each_with_index do |row, idx1|
      row_str = ""
      row.each_with_index do |tile, idx2|
        if idx2 % 3 == 2 && idx2 != 8
          row_str += (color_version(tile) + "|")
        else
          row_str += (color_version(tile) + " ")
        end
      end
      puts row_str.chomp
      if idx1 % 3 == 2 && idx1 != 8
        puts "-" * 17
      end
    end
  end

  def color_version(tile)
    tile.given ? tile.to_s.colorize(:blue) : tile.to_s
  end

  def row_check(grid)
    grid.each do |row|
      next if row.first.value == "-"
      string_row = row.map{ |tile| tile.to_s }
      return false unless string_row.sort == %w(1 2 3 4 5 6 7 8 9)
    end
    true
  end

  def col_check(grid)
    row_check(grid.transpose)
  end

  def check_boxes
    (0..2).each do |row|
      (0..2).each do |col|
        return false unless check_box(row*3, col*3)
      end
    end
    true
  end

  def check_box(start_row, start_col)
    nums = []
    (start_row..start_row+2).each do |row|
      (start_col..start_col+2).each do |col|
        nums << @grid[row][col].value
      end
    end

    nums.sort ==  %w(1 2 3 4 5 6 7 8 9)
  end

  def solved?
    return row_check(@grid) && col_check(@grid) && check_boxes
  end

  def update_tile(pos, val)
    row, col = pos
    @grid[row][col].value = val
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.from_file("sudoku1-solved.txt")
  b.render
  puts b.solved?
end
