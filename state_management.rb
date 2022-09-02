# frozen_string_literal: true

require_relative 'game_logic'

# State Machine
class StateManagement
  attr_reader :game_logic, :counter, :has_game_finished, :has_player_won, :target_word, :TARGET_WORDS

  TARGET_WORDS = %w[About Alert Argue Beach Above Found Guess Doubt Every Frame Guest
                    Dozen Exact Frank Guide Draft Exist Fraud Happy Drama Extra Fresh Harry Drawn Faith Front Heart Dream].freeze

  def initialize
    @target_word = TARGET_WORDS.sample.downcase
    @counter = 0
    @has_player_won = false
    @has_game_finished = false
    @game_logic = GameLogic.new
    @game_in_progress = true
  end

  def validate_guess(guess)
    guess.length == 5
  end

  def guess(user_guess)
    @counter += 1
    if @game_logic.win?(@game_logic.check_guess(user_guess, @target_word))
      @game_in_progress = false
      @has_player_won = true
    elsif @counter == 5
      @game_in_progress = false
      @has_game_finished = true
    end
  end

  def game_in_progress?
    @game_in_progress == true
  end

  def guess_result(user_guess)
    print @game_logic.check_guess(user_guess, @target_word)
  end

  def out_of_lives?
    true if game_finished? && counter == 5
  end

  def game_finished?
    @has_game_finished == true
  end

  def won?
    @has_player_won
  end
end
