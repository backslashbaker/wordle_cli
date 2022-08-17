# frozen_string_literal: true

# Checks whether letters are in target word, Validates guesses and whether a game has won.
class GameLogic
  def check_guess(guess, target)
    guess = guess.split('')
    target = target.split('')
    guess.each_with_index.map do |letter, _index|
      if target.include?(letter) && guess.find_index(letter) == target.find_index(letter)
        2
      elsif target.include?(letter) && guess.find_index(letter) != target.find_index(letter)
        1
      else
        0
      end
    end
  end

  def validate_guess(guess)
    true if guess.length == 5
  end

  def win?(word)
    word.all? { |letter| letter == 2 }
  end
end
