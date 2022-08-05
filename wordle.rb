require_relative 'game_logic'
require_relative 'messages'

class Wordle

    attr_accessor :game_logic, :messages
    attr_reader :TARGET_WORDS

    TARGET_WORDS = ['About', 'Alert', 'Argue', 'Beach', 'Above', 'Found', 'Guess', 'Doubt', 'Every', 'Frame', 'Guest', 'Dozen', 'Exact', 'Frank', 'Guide', 'Draft', 'Exist', 'Fraud', 'Happy', 'Drama', 'Extra', 'Fresh', 'Harry', 'Drawn', 'Faith', 'Front', 'Heart', 'Dream']


    def initialize
        @game_logic = GameLogic.new
        @messages = Messages.new
    end

    def play
        @messages.welcome_message
        @messages.rules
        @messages.request_word
        counter = 1
        target_word = TARGET_WORDS.sample.downcase
        guess = gets.chomp

        if @game_logic.validate_guess(guess)
            until @game_logic.win?(@game_logic.check_guess(guess, target_word)) ||counter == 5
                print @game_logic.check_guess(guess, target_word)
                puts "\n"
                @messages.request_word
                guess = gets.chomp
                @game_logic.check_guess(guess, target_word)
                counter += 1
            end

            if @game_logic.win?(@game_logic.check_guess(guess, target_word))
                @messages.winning_message(target_word)
                print @game_logic.check_guess(guess, target_word)
            elsif counter == 5
                @messages.out_of_lives
                puts "\n"
                print @game_logic.check_guess(guess, target_word)
                puts "\n"
                puts "the word was: #{target_word}"
            end

        else
            @messages.incorrect_word_length
            puts "\n\n"
            play
        end
            
    end

end

wordle = Wordle.new

wordle.play