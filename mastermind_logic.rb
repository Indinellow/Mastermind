# frozen_string_literal: true

# module which is used to compare guesses to code
module MastermindLogic
  def compare(guess, code)
    temp_guess = guess.clone
    temp_code = code.clone
    @exact = check_exact(temp_guess, temp_code)
    @same = check_same(temp_guess, temp_code)
    [@exact, @same]
  end

  def check_exact(guess, code)
    exact = 0
    guess.each_with_index do |element, index|
      next unless element == code[index]

      exact += 1
      guess[index] = '!'
      code[index] = '!'
    end
    exact
  end

  def check_same(guess, code)
    same = 0
    guess.each_with_index do |element, index|
      next unless element != '!' && code.include?(element)

      same += 1
      temp_index = code.index(element)
      guess[index] = '.'
      code[temp_index] = '.'
    end
    same
  end

  def correct?(guess, code)
    guess == code
  end
end
