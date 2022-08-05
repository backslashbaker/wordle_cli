class GameLogic
    def check_guess(guess, target)

        guess = guess.split('')
        target = target.split('')

        check_letters = guess.each_with_index.map do |letter, index| 
            if target.include?(letter) && guess.find_index(letter) == target.find_index(letter)
                2
            elsif target.include?(letter) && guess.find_index(letter) != target.find_index(letter)
                1
            else
                0
            end
        end

        check_letters
    end

    def validate_guess(guess)
       if guess.length == 5
        true
       end
    end

    def win?(word)
        word.all? { |letter| letter == 2 }
    end
end