$LOAD_PATH.unshift "E:/LEKCII/Ruby/Bubble"

require 'lib/iostream'
require 'lib/score'

require "highline/system_extensions"
include HighLine::SystemExtensions

class InputOutput
  def initialize
    IOStream.output " Hello there! What would you like to do?"
	  IOStream.output "1. Play a game!"
	  IOStream.output "2. I want to select a level first"
	  IOStream.output "3. What is my highscore?"
	  IOStream.output "4. Get me out of here!"
    IOStream.outprint "\nI would like to: "
	  key = IOStream.input
    IOStream.output key
	  no_key_pressed if key < 1 or key > 4
	  analyze_menu_data(key)
  end

  def no_key_pressed
    IOStream.output " You didn't choose anything from the menu! Let's try again.\n\n"
	  initialize
  end

  def analyze_menu_data(key)
    case key
      when 1 then Game.new(6, 3, 2)
      when 2 then Level.new
      when 3 then IOStream.output Score.new.get_highscore
      when 4 then IOStream.output "Bye!"
    end
  end

  def get_playing_data
    IOStream.outprint "x: "
    x = IOStream.input
    IOStream.output x
	  IOStream.outprint "y: "
	  y = IOStream.input
    IOStream.output y
    [x, y]
  end

  def matrix_output(matrix)
    IOStream.output matrix.map(&:inspect)
  end
end

class Level
  def initialize
    IOStream.output "Which level would you like to play?"
    IOStream.output "1 - Beginner (6x3)"
    IOStream.output "2 - Medium (6x6)"
    IOStream.output "3 - Hard (8x7)"
    IOStream.output "4 - Choose gameboard yourself"
    IOStream.outprint "\nI choose: "
    level = IOStream.input
    IOStream.output level
	  IOStream.output "That's not an option. Choose again.\n\n" if level < 1 or level > 4
	  analyze_level_data(level)
  end

  def analyze_level_data(level)
    case level
      when 1 then (Game.new(6, 3, 2))
      when 2 then (Game.new(6, 6, 3))
      when 3 then (Game.new(8, 7, 4))
      when 4 then choose_gameboard_yourself
      else initialize
    end
  end

  def choose_gameboard_yourself
    IOStream.outprint "rows: "
    rows = IOStream.input
    IOStream.output rows
	  IOStream.outprint "columns: "
	  columns = IOStream.input
    IOStream.output columns
    IOStream.outprint "colours: "
    colours = IOStream.input
    IOStream.output colours
    Game.new(rows, columns, colours)
  end
end