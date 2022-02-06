# frozen_string_literal: true

require './mastermind_logic.rb'
require './game.rb'

# class for case when player chooses to be breaker
class PlayerBreaker

  include MastermindLogic

  attr_reader :code, :tries

  def initialize
    @code = []
    4.times do
      code.push(rand(1..6).to_s)
    end
    @tries = 0
    @win = false
  end

  def input_guess
    puts 'Enter your guess!'
    @guess = gets.chomp.to_s.split('')
    if @guess.length != 4
      puts 'You need to write 4 numbers!'
      input_guess
    end
    @guess
  end

  def play_one_round
    @guess = input_guess
    if correct?(@guess,@code)
      p "you cracked the code :)"
      @win = true
    elsif
      compare(@guess, @code)
      p "Exact matches: #{@exact}"
      p "Same numbers, but wrong place: #{@same}"
    end
    @tries += 1
  end

  def play_game
  while !@win && @tries <=12 
    play_one_round    
  end
  end
end