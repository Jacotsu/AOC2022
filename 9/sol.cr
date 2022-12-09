include Math

class Vector
  property x : Int32, y : Int32
  def_hash @x, @y

  def initialize(@x = 0, @y = 0)
  end

  def +(other : Vector)
    return Vector.new x + other.x, y + other.y
  end

  def -(other : Vector)
    return Vector.new x - other.x, y - other.y
  end

  def ==(other : Vector)
    return x == other.x && y == other.y
  end

  def distance(other : Vector) : Int32
    diff_vec = (self - other)
    return sqrt((diff_vec.x**2) + (diff_vec.y**2)).floor.to_i
  end
end

File.open("input.txt") do |file|
  positions = Set(Vector).new
  head = Vector.new
  tail = Vector.new
  positions.add tail

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
      old_head = head
      head += dir_vec
      if head.distance(tail) > 1
        tail = old_head
        positions.add tail
      end
    end
  end
  puts positions.size
end
