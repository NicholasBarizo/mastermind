class Mastermind
  def initialize; end

  def begin
    play
  end

  private

  def play
    code = create_code
    
    puts 'Choose four colors from the following: Red, Orange, Yellow, Green, Blue, Purple'
    guess = get_guess
    puts guess
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
      input = gets.chomp.gsub(/,/, '').split
      input.each do |color|
        allowed_input.push(color) if possible_inputs.include?(color)
      end
    end
    allowed_input.pop while allowed_input.length > 4
    allowed_input.map do |color|
      case color
      when 'r' then 'red'
      when 'o' then 'orange'
      when 'y' then 'yellow'
      when 'g' then 'green'
      when 'b' then 'blue'
      when 'p' then 'purple'
      end
    end
  end
end

Mastermind.new.begin
