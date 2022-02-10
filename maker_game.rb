# frozen_string_literal: true


require './mastermind_logic.rb'
require './game_text.rb'

# class for case when player chooses to be the maker,
# so computer is the breaker
class MakerGame

  include MastermindLogic

  attr_reader :code, :possible_codes, :all_codes, :guess

  
  def initialize
    p 'Please enter your code'
    @tries = 0
    @guess = [1.to_s, 1.to_s, 2.to_s, 2.to_s]
    @code = gets.chomp.to_s.split('')
    @win = false
    @used_guesses = []
    @all_possible_matches = []
    [0, 1, 2, 3, 4].each do |first|
      [0, 1, 2, 3, 4].each do |second|
        @all_possible_matches.push([first, second])
      end
    end
  end

  def create_all_codes
    @possible_codes=[]
    [1,2,3,4,5,6].each do |first|
      [1,2,3,4,5,6].each do |second|
        [1,2,3,4,5,6].each do |third|
          [1,2,3,4,5,6].each do |fourth|
            @possible_codes.push([first.to_s, second.to_s, third.to_s, fourth.to_s])
          end
        end
      end
    end
    @all_codes = @possible_codes
  end

  def create_possible_codes(set, matches, guess)
    temp_codes = []
    set.each do |element|
      if compare(element, guess) == matches
        temp_codes.push(element)
      end
    end
    temp_codes
  end

  def complement_array(universe, array)
    complement = []
    universe.each do |element|
      complement.push(element) unless array.include?(element)
    end
    complement
  end

  def maximal_elimination(minimal_eliminations)
    max_elim = []
    max_elim_number = minimal_eliminations.max_by { |element| element[1] }[1]
    minimal_eliminations.each do |element|
      max_elim.push(element[0]) if element[1] = max_elim_number
    end
    next_guess = []
    max_elim.each do |element|
      next_guess.push(element) if @possible_codes.include?(element)
    end
    if next_guess.empty?
      return max_elim[0]
    else
      return next_guess[0]
    end
  end

  def minimal_eliminations
    min_elim = []
    not_used_guesses = complement_array(@all_codes,@used_guesses)
    not_used_guesses.each do |element|
      all_lengths = []
      @all_possible_matches.each do |match|
        len = create_possible_codes(@possible_codes,match,element).length
        all_lengths.push(len)
      end
      min_elim.push([element, all_lengths.min])
    end
    min_elim
  end

  def minimax
    min_set = minimal_eliminations
    @guess = maximal_elimination(min_set)
  end

  def play_maker_game
    create_all_codes
    until @win || @tries >= 7
      puts "\n \n"
      p "Try number #{@tries+1}"
      p "My guess is:"
      p @guess
      @matches = compare(@guess, @code)
      p "Exact matches: #{@exact}"
      puts "Same numbers, but wrong place: #{@same} \n"
      @used_guesses.push(@guess)
      if @matches == [4, 0]
        @win = true
        p "The computer cracked your code!"
      end
      @possible_codes = create_possible_codes(@possible_codes, @matches, @guess)
      #p "number of possible codes:"
      #p @possible_codes.length
      puts "Hmm.. let me think a bit \n \n" unless @win
      minimax
      @tries += 1
      
    end
  end 

end
