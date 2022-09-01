require_relative 'game_logic'


class StateManagement
    attr_reader :game_logic, :counter, :has_game_finished, :has_player_won, :target_word, :TARGET_WORDS

    TARGET_WORDS = %w[About Alert Argue Beach Above Found Guess Doubt Every Frame Guest
        Dozen Exact Frank Guide Draft Exist Fraud Happy Drama Extra Fresh Harry Drawn Faith Front Heart Dream].freeze
        
    def initialize
        @target_word = TARGET_WORDS.sample.downcase
        @counter = 1
        @has_player_won = false
        @has_game_finished = false
        @game_logic = GameLogic.new
    end

    def validate_guess(guess)
        guess.length == 5
    end

    def guess(user_guess)
        @counter += 1
        if @game_logic.win?(@game_logic.check_guess(user_guess, @target_word))
            @has_player_won = true
        elsif @counter == 5
            @has_game_finished = true
        end
    end

    def guess_result(user_guess)
        print @game_logic.check_guess(user_guess, @target_word)
    end

    def out_of_lives?
        if game_finished? && counter == 5
            true
        end
    end

    def game_finished?
        @has_game_finished == true
    end

    def won?
        @has_player_won
    end

#     Wordle State Machine
# Events:
# Guess
# SetWordList
# ResetMachine

# State:
# Counter
# HowManyGoesHaveBeenMade
# HasThePlayerWon?
# WasTheGameFinished?

# States:
# - GameInProgress
# - PlayerHasWonFinished
# - PlayerHasLostFinished
end