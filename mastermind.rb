class Mastermind
  def initialize; end

  def begin
    play
  end

  private

  def play
    code = create_code
    code.each { |word| puts word }
  end

  def create_code
    colors = %w[red orange yellow green blue purple]
    code = []
    4.times do
      code.push colors.sample
    end
    code
  end
end

Mastermind.new.begin
