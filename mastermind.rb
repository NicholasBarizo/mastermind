class Mastermind
  def initialize; end

  def begin
    play
  end

  private

  def play
    code = create_code
    12.downto(1) do |num|
      puts "You have #{num} guesses remaining"
      puts 'Choose four colors from the following: Red, Orange, Yellow, Green, Blue, Purple'
      positions = determine_positions(get_guess, code)
      if positions[:right_position] < 4
        puts "#{positions[:right_position]} of the guessed colors are in the correct position"
        puts "#{positions[:wrong_position]} of the guessed colors are in the incorrect position"
        puts "#{positions[:remaining]} of the guessed colors are not found in the code"
      else
        puts "You win! The code was #{code.join(', ')}"
        puts 'Play Again? (y/n)'
        play_again = gets.chomp.downcase
        case play_again
        when 'y'
          Mastermind.new.begin
        when 'n'
          puts 'Goodbye!'
          exit
        end
      end
    end
  end

  def create_code
    colors = %w[red orange yellow green blue purple]
    code = []
    4.times do
      code.push colors.sample
    end
    code

  end

  def get_guess
    input = gets.chomp.downcase.gsub(/,/, '').split
    possible_inputs = %w[red r orange o yellow y green g blue b purple p]
    allowed_input = []
    input.each do |color|
      allowed_input.push(color) if possible_inputs.include?(color)
    end
    while allowed_input.length < 4
      color_plural = allowed_input.length == 3 ? '' : 's'
      puts "You need to pick #{4 - allowed_input.length} more color#{color_plural}"
      input = gets.chomp.downcase.gsub(/,/, '').split
      input.each do |color|
        allowed_input.push(color) if possible_inputs.include?(color)
      end
    end
    allowed_input.pop while allowed_input.length > 4
    color_translate = {
      'r' => 'red',
      'o' => 'orange',
      'y' => 'yellow',
      'g' => 'green',
      'b' => 'blue',
      'p' => 'purple'
    }
    translated_input = allowed_input.map do |color|
      color_translate[color]
    end
    puts "You guessed: #{translated_input.join(', ')}"
    translated_input
  end

  def determine_positions(guess, code)
    positions = {
      wrong_position: 0,
      right_position: 0
    }

    guess.each_with_index do |guess_color, guess_index|
      code.each_with_index do |code_color, code_index|
        if guess_color == code_color && guess_index == code_index
          positions[:right_position] += 1
        elsif guess_color == code_color && code_index > guess_index
          positions[:wrong_position] += 1
        end

      end
    end
    positions[:remaining] = 4 - (positions[:wrong_position] + positions[:right_position])
    positions
  end
end

Mastermind.new.begin
