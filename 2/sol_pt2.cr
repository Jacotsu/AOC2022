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
    when 'A' then @type = Moves::Rock
    when 'B' then @type = Moves::Paper
    when 'C' then @type = Moves::Scissors
    end
  end

  def initialize(@type : Moves)
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


class Outcome
  include Comparable(Outcome)

  property outcome : RoundOutcomes = RoundOutcomes::Draw
  #def_equals @outcome

  def initialize(outcome : Char)
    case outcome
    when 'X' then @outcome = RoundOutcomes::Lost
    when 'Y' then @outcome = RoundOutcomes::Draw
    when 'Z' then @outcome = RoundOutcomes::Win
    end
  end

  def to_s(io : IO)
    @outcome.to_s io
  end

  def <=>(other : Outcome)
    @outcome.<=> other.@outcome
  end

  def <=>(other : RoundOutcomes)
    @outcome.<=> other
  end

  def ==(other : RoundOutcomes)
    @outcome == other
  end
end


File.open("input.txt") do |file|
  total_score = 0
  file.each_line do |line|
    moves = line.split
    opponent_move = Move.new moves[0][0]
    desired_outcome = Outcome.new moves[1][0]

    case
    # Win
    when desired_outcome == RoundOutcomes::Win
      your_move = Move.new Moves.from_value opponent_move.value % 3 + 1
      total_score += your_move.value + RoundOutcomes::Win.value
    # Draw
    when desired_outcome == RoundOutcomes::Draw
      your_move = opponent_move
      total_score += your_move.value + RoundOutcomes::Draw.value
    # Lose
    else
      desired_value = opponent_move.value % 3 + 1
      desired_value = desired_value % 3 + 1
      your_move = Move.new Moves.from_value desired_value
      total_score += your_move.value
    end
  end
  puts total_score
end
