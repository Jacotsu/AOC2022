class Monkey
  property inspected_items = 0

  def initialize(@items : Array(Int32), @operation : Int32 -> Int32,
      @test_modulus : Int32, @test_result : Tuple(Int32, Int32))
  end

  def inspect_next(monkeys : Array(Monkey))
    while item = @items.shift?
      @inspected_items += 1
      new_item = (@operation.call(item) / 3).floor.to_i
      if new_item % @test_modulus == 0
        monkeys[@test_result[0]].push new_item
      else
        monkeys[@test_result[1]].push new_item
      end
    end
  end

  def push(item : Int32)
    @items.push item
  end

  def to_s(io : IO)
    io << "#{@test_modulus}|#{@test_result}|#{@items}"
  end
end

def parse_monkey(lines : Array(String)) : Monkey
  starting_items = Array(Int32).new
  lines[1].split(':')[1].split(", ", remove_empty: true).map { |x|
    starting_items.push x.to_i
  }

  operator, number = lines[2].split.pop 2
  case operator
  when "*"
    if number == "old"
      op = ->(x : Int32) { x * x }
    else
      op = ->(x : Int32) { x * number.to_i }
    end
  else
    if number == "old"
      op = ->(x : Int32) { x + x }
    else
      op = ->(x : Int32) { x + number.to_i }
    end
  end

  test_modulus = lines[3].split.pop.to_i
  success = lines[4].split.pop.to_i
  fail = lines[5].split.pop.to_i
  return Monkey.new starting_items, op, test_modulus, {success, fail}
end

input = File.read_lines("input.txt")
monkeys = Array(Monkey).new

input.each_slice(7) { |x|  monkeys.push parse_monkey x }

20.times do
  monkeys.each do |x|
    x.inspect_next monkeys
  end
end

inspected_items = Array(Tuple(Int32, Int32)).new
monkeys.each.with_index do |x, i|
  inspected_items.push({ i, x.inspected_items })
end
inspected_items.sort! { |x, y| y[1] <=> x[1] }
puts inspected_items[0, 2].product { |x| x[1] }
