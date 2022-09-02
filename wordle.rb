# frozen_string_literal: true

require_relative 'game_logic'
require_relative 'messages'
require_relative 'state_management'

# Game flow
class Wordle
  attr_accessor :game_logic, :messages, :state_machine

  def initialize
    @game_logic = GameLogic.new
    @messages = Messages.new
    @state_machine = StateManagement.new
  end

  def play
    display_messages
    user_guess = gets.chomp.downcase

    if @state_machine.validate_guess(user_guess)
      game_loop(user_guess)
      if @state_machine.won?
        print "\n"
        @messages.winning_message(@state_machine.target_word)
      elsif @state_machine.out_of_lives?
        @messages.out_of_lives
        puts "\n"
        puts "the word was: #{@state_machine.target_word}"
      end

    else
      @messages.incorrect_word_length
      puts "\n\n"
      play
    end
  end

  private

  def display_messages
    @messages.welcome_message
    @messages.rules
    @messages.request_word
  end

  def game_loop(user_guess)
    while @state_machine.game_in_progress?
      @state_machine.guess_result(user_guess)
      if @state_machine.guess(user_guess)
        break
      else
        print "\n"
        @messages.request_word
        user_guess = gets.chomp.downcase
      end
    end
  end
end

wordle = Wordle.new

wordle.play
