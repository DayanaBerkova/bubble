$LOAD_PATH.unshift "E:/LEKCII/Ruby/Bubble/lib"

require 'iostream'

class Score
  attr_reader :score
  def initialize
    @score = 0
    @highscore = 0
  end

  def make_a_score(value)
    @score += value * value
    "You've scored: #{@score}!"
  end

  def highscore
    new_highscore = ""
    if not File.exist?('..\res\highscore.txt') or @score > File.new('..\res\highscore.txt').readline.to_i
      File.open('..\res\highscore.txt', 'w') { |score| score.write @score }
      new_highscore =  "New Highscore!\n"
    end
    IOStream.output "#{new_highscore}Game over."
  end

  def get_highscore
    if File.exist?('..\res\highscore.txt') and File.open('..\res\highscore.txt').readline.to_i != 0
      f = File.new('..\res\highscore.txt')
      IOStream.output "Your current highscore is #{f.readline}.\n\n"
    else
      IOStream.output "You have no highscore yet. Play a game first.\n\n"
    end
  end

  def delete_highscore
    if File.exist?('..\res\highscore.txt')
      File.open('..\res\highscore.txt', 'w') { |score| score.write '0'}
    else
      IOStream.output "You don't have a highscore yet.\n\n"
    end
  end
end