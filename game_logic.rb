# frozen_string_literal: true

# Checks whether letters are in target word, Validates guesses and whether a game has won.
class GameLogic
  def check_guess(guess, target)
    guess_letters = guess.split('')
    target_letters = target.split('')
    guess_letters.each_with_index.map do |letter, _index|
      correct_letter_and_position = target_letters.include?(letter) && guess_letters.find_index(letter) == target_letters.find_index(letter)
      correct_letter_wrong_position = target_letters.include?(letter) && guess_letters.find_index(letter) != target_letters.find_index(letter)

      correct_letter_and_position ? 2 : correct_letter_wrong_position ? 1 : 0
    end
  end

  def win?(word_array)
    word_array.all? { |letter| letter == 2 }
  end

end
