enum Moves
  Rock = 1
  Paper
  Scissors
end

enum RoundOutcomes
  Lost = 0
  Draw = 3
  Win = 6
end

class Move
  include Comparable(Move)

  property type : Moves = Moves::Rock

  def initialize(type : Char)
    case type
    when 'A', 'X'
      @type = Moves::Rock
    when 'B', 'Y'
      @type = Moves::Paper
    when 'C', 'Z'
      @type = Moves::Scissors
    end
  end

  def value()
    @type.value
  end

  def to_s(io : IO)
    @type.to_s io
  end

  def <=>(other : Move)
    val = @type.value - other.@type.value
    val = val.abs > 1 ? -val : val
    return val.clamp -1, 1
  end

end


File.open("input.txt") do |file|
  total_score = 0
  file.each_line do |line|
    moves = line.split
    opponent_move = Move.new moves[0][0]
    your_move = Move.new moves[1][0]
    case
    # Win
    when your_move > opponent_move
      total_score += your_move.value + RoundOutcomes::Win.value
    # Draw
    when your_move == opponent_move
      total_score += your_move.value + RoundOutcomes::Draw.value
    # Lose
    else
      total_score += your_move.value
    end
  end
  puts total_score
end
