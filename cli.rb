# frozen_string_literal: true

require_relative 'game'
require_relative 'messages'

def green(text)
  "\e[1;32m#{text}\e[0m"
end

def amber(text)
  "\e[1;33m#{text}\e[0m"
end

def red(text)
  "\e[1;31m#{text}\e[0m"
end

game = Game.start
puts "\e[1;34m#{Messages.welcome_message}\e[0m"
puts Messages.rules
loop do
  puts Messages.request_word game.turn
  # puts game.state.to_json
  guess = gets.chomp.downcase
  game.take_turn guess

rescue Game::InvalidWord => e
  puts e
  puts Messages.incorrect_word_length
rescue Game::IncorrectWord => e
  outcome = e.outcome.each_with_index.map do |score, index|
    case score
    when 0
      red guess[index]
    when 1
      amber guess[index]
    when 2
      green guess[index]
    end
  end

  puts outcome.to_a.join ''
  puts 'Incorrect word'
ensure
  if game.finished?
    if game.won?
      puts Messages.winning_message(guess)
      exit 0
    end
    puts Messages.out_of_lives
    exit 1
  end
end
