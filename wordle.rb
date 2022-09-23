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
    loop do
      if @state_machine.lost?
        @messages.out_of_lives
        puts "\n"
        puts "the word was: #{@state_machine.target_word}"
        exit 1
      end

      if @state_machine.won?
        @messages.winning_message(@state_machine.target_word)
        exit 0
      end

      display_messages
      
      user_guess = gets.chomp.downcase
      

      
    end
  end

  private

  def display_messages
    @messages.welcome_message
    @messages.rules
    puts "turn #{@state_machine.counter + 1}"
    @messages.request_word
  end

  def take_turn(state, guess)
    unless state.valid? guess
      @messages.incorrect_word_length
      next
    end

    state.guess_result guess unless state.correct? guess
  end
end

wordle = Wordle.new

wordle.play
