class Mastermind
    COLORS = %w[1 2 3 4 5 6].freeze
    CODE_LENGTH = 4
    MAX_TURNS = 12
  
    def initialize
      @secret_code = generate_secret_code
      @turns_left = MAX_TURNS
    end
  
    def play
      puts "Welcome to Mastermind!"
      puts "The secret code is a combination of four numbers: 1, 2, 3, 4, 5, and 6."
      puts "You have #{MAX_TURNS} turns to guess the code. Good luck!\n\n"
  
      while @turns_left > 0
        puts "Turns left: #{@turns_left}"
        guess = get_player_guess
  
        if guess == @secret_code
          puts "Congratulations! You guessed the secret code!"
          return
        else
          display_feedback(guess)
          @turns_left -= 1
        end
      end
  
      puts "Sorry, you're out of turns. The secret code was: #{@secret_code}"
    end
  
    private
  
    def generate_secret_code
      CODE_LENGTH.times.map { COLORS.sample }
    end
  
    def get_player_guess
      loop do
        print "Enter your guess (e.g., '1 2 3 4'): "
        input = gets.chomp.split.map(&:to_i)
        return input if valid_guess?(input)
  
        puts "Invalid guess. Please make sure to enter exactly #{CODE_LENGTH} valid numbers from: #{COLORS.join(', ')}"
      end
    end
  
    def valid_guess?(guess)
      guess.length == CODE_LENGTH && guess.all? { |num| COLORS.include?(num.to_s) }
    end
  
    def display_feedback(guess)
      feedback = guess.map.with_index do |number, index|
        if number == @secret_code[index].to_i
          'Black'
        elsif @secret_code.include?(number.to_s)
          'White'
        end
      end.compact.shuffle
  
      puts "Feedback: #{feedback.join(', ')}"
    end
  end
  
  # Start the game
  game = Mastermind.new
  game.play