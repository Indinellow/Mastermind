# frozen_string_literal: true

require './mastermind_logic.rb'
require './maker_game.rb'
require './breaker_game.rb'
require './game_text.rb'

# class for the entire game
class Game
  include GameText

  def pick_role
    puts "Do you want to create the code or try and guess the code?"
    p "If you want to make the code, enter 'maker'"
    p "If you want to try and guess the code enter 'breaker'"
    @choice = gets.chomp.downcase
    if @choice == 'maker'
      p "You want to make the code!"
    elsif @choice == 'breaker'
      p "you want to break the code!"
    else 
      p "That option is not supported, please try again."
      pick_role
    end
  end

  def play
    instructions
    pick_role
    if @choice == 'maker'
      computer = MakerGame.new
      computer.play_maker_game
    else
      player = BreakerGame.new
      player.play_breaker_game
    end
  end
end


