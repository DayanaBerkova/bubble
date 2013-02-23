$LOAD_PATH.unshift "E:/LEKCII/Ruby/Bubble/bin"

require 'game'
require 'minitest/autorun'

class TestGame < MiniTest::Unit::TestCase
  def test_reducing_matrix
    IOStream.test = true
    game1 = Game.new(3, 3, 2, [[0, 0, 0],
                               [1, 0, 2],
                               [1, 0, 1]])
    game2 = Game.new(3, 3, 2, [[0, 1, 0],
                               [1, 0, 2],
                               [1, 0, 1]])
    game3 = Game.new(3, 3, 2, [[1, 2, 2],
                               [0, 1, 1],
                               [1, 0, 1]])
    assert_equal 1, game1.delete_blank_rows_or_columns
    assert_equal 0, game2.delete_blank_rows_or_columns

    assert_equal [[1, 2],
                  [1, 1]] , game1.reduce_matrix
    assert_equal [[0, 1, 0],
                  [1, 0, 2],
                  [1, 0, 1]], game2.reduce_matrix
    assert_equal [[1, 2, 2],
                  [0, 1, 1],
                  [1, 0, 1]], game3.reduce_matrix

    assert_equal [[1, 0, 2],
                  [1, 1, 1]], game2.reduce_blank_spots
    assert_equal [[0, 0, 2],
                  [1, 2, 1],
                  [1, 1, 1]], game3.reduce_blank_spots
  end

  def test_handling_mistakes
    IOStream.test = true
    game = Game.new(3, 4, 2, [[0, 0, 0],
                              [1, 0, 2],
                              [1, 0, 1]])
    assert_equal "Nice try! But you can't do that.", game.possible_mistakes(0, 1)
    assert_equal "Nope, not the right coordinates.", game.possible_mistakes(4, 3)
    assert_equal nil, game.possible_mistakes(1, 0)
  end

  def test_no_possible_moves
    IOStream.test = true
    game1 = Game.new(3, 3, 2, [[0, 0, 0],
                               [1, 0, 2],
                               [1, 0, 1]])
    game2 = Game.new(2, 2, 2, [[1, 0],
                               [0, 1]])
    game3 = Game.new(1, 3, 2, [[1, 0, 2]])

    assert_equal true, game1.none_acceptable_moves(1, 2)
    assert_equal false, game1.none_acceptable_moves(1, 0)
    assert_equal true, game1.none_acceptable_moves(0, 0)
    assert_equal true, game2.none_acceptable_moves(0, 0)
    assert_equal true, game3.none_acceptable_moves(0, 2)

    assert_equal false, game1.no_more_moves
    assert_equal true, game2.no_more_moves
    assert_equal true, game3.no_more_moves
  end

  def test_popping_bubbles
    IOStream.test = true
    game1 = Game.new(3, 3, 2, [[0, 0, 0],
                               [1, 0 , 2],
                               [1, 0, 2]])
    game2 = Game.new(4, 5, 2, [[1, 1, 2, 1, 2],
                               [2, 2, 1, 2, 2],
                               [1, 2, 1, 2, 1],
                               [2, 2, 2, 1, 2]])
    game1.bubble(0, 1, 1)
    game2.bubble(0, 1, 1)
    assert_equal [[0, 0, 0],
                  [1, 0, 2],
                  [1, 0, 2]], game1.matrix
    assert_equal [[0, 0, 2, 1, 2],
                  [2, 2, 1, 2, 2],
                  [1, 2, 1, 2, 1],
                  [2, 2, 2, 1, 2]], game2.matrix
    game1.bubble(1, 0, 1)
    game2.bubble(1, 0, 2)
    assert_equal [[0, 0, 0],
                  [0, 0, 2],
                  [0, 0, 2]], game1.matrix
    assert_equal [[0, 0, 2, 1, 2],
                  [0, 0, 1, 2, 2],
                  [1, 0, 1, 2, 1],
                  [0, 0, 0, 1, 2]], game2.matrix
    game1.bubble(1, 2, 2)
    game2.bubble(1, 3, 2)
    assert_equal [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]], game1.matrix
    assert_equal [[0, 0, 2, 1, 0],
                  [0, 0, 1, 0, 0],
                  [1, 0, 1, 0, 1],
                  [0, 0, 0, 1, 2]], game2.matrix
  end
end