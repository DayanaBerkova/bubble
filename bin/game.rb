$LOAD_PATH.unshift "../"

require 'lib/iostream'
require 'bin/menu'
require 'lib/score'

class Game < InputOutput
  attr_accessor :matrix
  def initialize(rows = 0, columns = 0, number_of_bubbles = 1, matrix = 0)
    @rows, @columns, @number_of_bubbles= rows, columns, number_of_bubbles
    @score = Score.new
    @points = 0
    return @matrix = matrix if matrix != 0
    @matrix = make_random_matrix
    matrix_output(@matrix)
    make_a_move
  end

  def make_random_matrix
    Array.new(@rows) { |i| Array.new(@columns) { |i| rand(1..@number_of_bubbles) }}
  end

  def make_a_move
    @points = 0
    x, y = get_playing_data
    IOStream.output possible_mistakes(x, y)
    sleep(0.8)
    reduce_blank_spots
	  matrix_output(@matrix)
    IOStream.output @score.make_a_score(@points)
    unless no_more_moves then make_a_move else @score.highscore end
  end

  def possible_mistakes(x, y)
    if x >= @rows or y >= @columns or x < 0 or y < 0
      "Nope, not the right coordinates."
    elsif @matrix[x][y] != 0 and (not none_acceptable_moves(x, y))
      bubble(x, y, @matrix[x][y])
    else
      "Nice try! But you can't do that."
    end
  end

  def reduce_blank_spots
    @matrix = @matrix.transpose
    @matrix.each_index do |x|
      zeros = @matrix[x].count(0)
      @matrix[x].delete(0)
      zeros.times { @matrix[x].unshift(0) }
    end
    @matrix = @matrix.transpose
    reduce_matrix
  end

  def reduce_matrix
    @rows -= delete_blank_rows_or_columns
    @matrix = @matrix.transpose
    @columns -= delete_blank_rows_or_columns
    @matrix = @matrix.transpose
  end

  def delete_blank_rows_or_columns
    delete_here = []
    br = 0
    @matrix.each_index { |x| delete_here << x and br += 1 if @matrix[x].all? { |y| y == 0 } }
    a = 0
    delete_here.map { |x| @matrix.delete_at(x - a); a += 1}
    br
  end

  def bubble(x, y, value)
    @points += 1
    @matrix[x][y] = 0
    bubble(x, y + 1, value) if y < @columns - 1 and @matrix[x][y + 1] == value
    bubble(x + 1, y, value) if x < @rows - 1 and @matrix[x + 1][y] == value
	  bubble(x, y - 1, value) if y > 0 and @matrix[x][y - 1] == value
    bubble(x - 1, y, value) if x > 0 and @matrix[x - 1][y] == value
  end

  def no_more_moves
    flag = []
    return true if @matrix.map { |i| i.uniq }.uniq == [[0]]
    @matrix.each_index { |x| @matrix[x].each_index { |y| flag << none_acceptable_moves(x, y) } }
    if flag.all? { |n| n == true } then true else false end
  end

  def none_acceptable_moves(x, y)
    not (@matrix[x][y] != 0 and
        ((y > 0 and @matrix[x][y - 1] == @matrix[x][y]) or 
         (y < @columns - 1 and @matrix[x][y + 1] == @matrix[x][y]) or
         (x > 0 and @matrix[x - 1][y] == @matrix[x][y]) or
         (x < @rows - 1 and @matrix[x + 1][y] == @matrix[x][y])))
  end
end

#InputOutput.new