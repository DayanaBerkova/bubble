$LOAD_PATH.unshift "../"

require 'lib/score'
require 'minitest/autorun'

class TestScore < MiniTest::Unit::TestCase

  def test_making_a_score
    score = Score.new
    assert_equal "You've scored: 144!", score.make_a_score(12)
    assert_equal "You've scored: 148!", score.make_a_score(2)
    assert_equal "You've scored: 157!", score.make_a_score(3)
  end

  def test_making_highscore
    IOStream.test = true
    assert_equal "Game over.", Score.new.highscore
    score = Score.new
    score.make_a_score(100)
    assert_equal "New Highscore!\nGame over.", score.highscore
    score.delete_highscore
  end

  def test_getting_highscore
    IOStream.test = true
    score = Score.new
    score.delete_highscore
    assert_equal "You have no highscore yet. Play a game first.\n\n", score.get_highscore
    File.open('..\res\highscore.txt', 'w') { |score| score.write '999' }
    assert_equal "Your current highscore is 999.\n\n", score.get_highscore
    score.make_a_score(5)
    assert_equal "Your current highscore is 999.\n\n", score.get_highscore
    Score.new.delete_highscore
  end

  def test_deleteing_highscore
    assert_equal 1, Score.new.delete_highscore
  end
end
