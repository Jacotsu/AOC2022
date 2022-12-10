include Math

class Vector
  property x : Int32, y : Int32
  def_equals_and_hash @x, @y

  def initialize(@x = 0, @y = 0)
  end

  def +(other : Vector)
    return Vector.new x + other.x, y + other.y
  end

  def -(other : Vector)
    return Vector.new x - other.x, y - other.y
  end

  def /(other : Float64)
    new_x = (x / other).abs.ceil*x.sign
    new_y = (y / other).abs.ceil*y.sign
    return Vector.new new_x.to_i, new_y.to_i
  end

  def abs
    return sqrt(x**2 + y**2)
  end

  def to_s(io : IO)
    io << "(#{x}, #{y})"
  end

  def distance(other : Vector) : Int32
    diff_vec = (self - other)
    return diff_vec.abs.floor.to_i
  end
end

LENGTH = 10

File.open("input.txt") do |file|
  positions = Set(Vector).new
  knots = Array(Vector).new LENGTH, Vector.new
  positions.add knots.last

  file.each_line do |line|
    direction, steps = line.split
    case direction
    when "R" then dir_vec = Vector.new 1, 0
    when "L" then dir_vec = Vector.new -1, 0
    when "U" then dir_vec = Vector.new 0, 1
    else
      dir_vec = Vector.new 0, -1
    end
    steps.to_i.times do |x|

      knots.each.with_index do |x, i|
        if i == 0
          knots[i] += dir_vec
        else
          dist_vec = knots[i - 1] - x
          if dist_vec.abs >= 2
            knots[i] += dist_vec/dist_vec.abs
          end
        end
      end

      positions.add knots.last
    end
  end
  puts positions.size
end
