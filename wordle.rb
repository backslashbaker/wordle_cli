# frozen_string_literal: true

require_relative 'game_logic'
require_relative 'messages'
require_relative 'state_management'

# Game flow
class Wordle
  attr_accessor :game_logic, :messages, :state_management

  def initialize
    @game_logic = GameLogic.new
    @messages = Messages.new
    @state_management = StateManagement.new
  end

  def display_messages
    @messages.welcome_message
    @messages.rules
    @messages.request_word
  end

  def play
    puts "the word was: #{@state_management.target_word}"
    display_messages
    user_guess = gets.chomp

    if @state_management.validate_guess(user_guess)
      until @state_management.won? || @state_management.game_finished?
        @state_management.guess(user_guess)
        @state_management.guess_result(user_guess)
        print "\n"
        @messages.request_word
        user_guess = gets.chomp
        @state_management.guess_result(user_guess)
      end

      if @state_management.won?
        print "\n"
        @messages.winning_message(@state_management.target_word)
        # @state_management.guess_result(user_guess)
      elsif @state_management.out_of_lives?
        @messages.out_of_lives
        @state_management.guess_result(user_guess)
        puts "\n"
        puts "the word was: #{@state_management.target_word}"
      end

    else
      @messages.incorrect_word_length
      puts "\n\n"
      play
    end
  end

  #   if @state_management.validate_guess(user_guess)
  #     @state_management.guess(user_guess) until @state_management.won? || @state_management.game_finished?
  #       @state_management.guess_result(user_guess)
  #       puts "\n"
  #       @messages.request_word
  #       user_guess = gets.chomp.downcase
  #     end

  #     if @state_management.won?
  #       @messages.winning_message(@state_management.target_word)
  #       @state_management.guess_result(user_guess)
  #     elsif @state_management.out_of_lives?
  #       @messages.out_of_lives
  #       puts "\n"
  #       puts "\n"
  #       puts "the word was: #{@state_management.target_word}"
  #     end

  #   else
  #     @messages.incorrect_word_length
  #     puts "\n\n"
  #     play
  #   end
  # end
end

wordle = Wordle.new

wordle.play
