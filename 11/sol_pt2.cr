class Monkey
  property inspected_items = 0

  def initialize(@items : Array(UInt64),
      @operation : UInt64 -> UInt64,
      @test_modulus : Int32, @test_result : Tuple(Int32, Int32))
  end

  def inspect_next(monkeys : Array(Monkey))
    max_mod = monkeys.product { |monkey| monkey.@test_modulus }
    while item = @items.shift?
      @inspected_items += 1
      new_item = @operation.call(item) % (max_mod )
      if new_item % @test_modulus == 0
        monkeys[@test_result[0]].push new_item
      else
        monkeys[@test_result[1]].push new_item
      end
    end
  end

  def push(item : UInt64)
    @items.push item
  end

  def to_s(io : IO)
    io << "#{@test_modulus}|#{@test_result}|#{@items}"
  end
end

def parse_monkey(lines : Array(String)) : Monkey
  # Store items as product of sum (a + b + c...)(d + e + f...)...
  starting_items = Array(UInt64).new
  lines[1].split(':')[1].split(", ", remove_empty: true).map { |x|
    starting_items.push x.to_u64
  }

  operator, number = lines[2].split.pop 2
  case operator
  when "*"
    if number == "old"
      op = ->(x : UInt64) { (x ** 2).to_u64 }
    else
      op = ->(x : UInt64) { x * number.to_u64 }
    end
  else
    if number == "old"
      op = ->(x : UInt64) { (2 * x).to_u64 }
    else
      op = ->(x : UInt64) { x + number.to_u64 }
    end
  end

  test_modulus = lines[3].split.pop.to_i
  success = lines[4].split.pop.to_i
  fail = lines[5].split.pop.to_i
  return Monkey.new starting_items, op, test_modulus, {success, fail}
end

input = File.read_lines("input.txt")
monkeys = Array(Monkey).new

input.each_slice(7) { |x| monkeys.push parse_monkey x }

10000.times do
  monkeys.each do |x|
    x.inspect_next monkeys
  end
end

inspected_items = Array(Tuple(Int32, UInt64)).new
monkeys.each.with_index do |x, i|
  inspected_items.push({ i, x.inspected_items.to_u64 })
end
inspected_items.sort! { |x, y| y[1] <=> x[1] }
puts inspected_items[0, 2].product { |x| x[1] }
