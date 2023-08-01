require 'test/unit'
require_relative 'mastermind'

class TestMastermind < Test::Unit::TestCase
  def test_generate_secret_code
    game = Mastermind.new
    secret_code = game.send(:generate_secret_code)

    assert_equal(Mastermind::CODE_LENGTH, secret_code.length, "Secret code should have #{Mastermind::CODE_LENGTH} elements")
    secret_code.each do |color|
      assert_includes(Mastermind::COLORS, color, "Invalid color in the secret code: #{color}")
    end
  end

  def test_valid_guess
    game = Mastermind.new

    assert(game.send(:valid_guess?, [1, 2, 3, 4]), "Valid guess should be accepted")
    assert(game.send(:valid_guess?, [6, 2, 1, 5]), "Valid guess should be accepted")

    assert_false(game.send(:valid_guess?, [1, 2]), "Guess with less than #{Mastermind::CODE_LENGTH} elements should be invalid")
    assert_false(game.send(:valid_guess?, [1, 2, 3, 4, 5]), "Guess with more than #{Mastermind::CODE_LENGTH} elements should be invalid")
    assert_false(game.send(:valid_guess?, [1, 2, 3, 7]), "Guess with an invalid color should be invalid")
  end

  def test_display_feedback
    game = Mastermind.new

    secret_code = [1, 2, 3, 4]

    feedback = game.send(:display_feedback, [1, 2, 3, 4])
    assert_equal(['Black', 'Black', 'Black', 'Black'], feedback, "Feedback for a correct guess should be all Blacks")

    feedback = game.send(:display_feedback, [4, 3, 2, 1])
    assert_equal(['White', 'White', 'White', 'White'], feedback, "Feedback for a correct guess with different order should be all Whites")

    feedback = game.send(:display_feedback, [1, 5, 6, 3])
    assert_equal(['Black', 'White'], feedback, "Feedback for partially correct guess should be Blacks and Whites")
  end
end