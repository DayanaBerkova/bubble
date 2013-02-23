$LOAD_PATH.unshift "E:/LEKCII/Ruby/Bubble/bin"

require 'menu'
require 'minitest/autorun'

class TestMenu < MiniTest::Unit::TestCase
  def test_analyzing_menu_data
    IOStream.test = true
    File.open('input.txt', 'w') { |menu_data| menu_data.write '4' }
    assert_equal "Bye!", InputOutput.new.analyze_menu_data(4)
    highscore = File.open('..\res\highscore.txt').readline.to_i
    if highscore != 0
      text = "Your current highscore is #{highscore}.\n\n"
    else 
      text = "You have no highscore yet. Play a game first.\n\n"
    end
    assert_equal text, InputOutput.new.analyze_menu_data(3)
  end

  def test_getting_playing_data
    IOStream.test = true
    assert_equal [4, 4], InputOutput.new.get_playing_data
  end

  def test_matrix_output
    IOStream.test = true
    assert_equal ["[1, 2, 3]","[1, 2, 3]"], InputOutput.new.matrix_output([[1, 2, 3], [1, 2, 3]])
  end
end