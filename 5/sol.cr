File.open("input.txt") do |file|
  #Read drawing
  crates_drawing = Array(String).new
  while true
    line = file.read_line
    break if line.empty?
    crates_drawing.push line
  end
  n_columns = crates_drawing.pop.split.pop.to_i
  crates_arrangment = Array(Array(Char)).new(n_columns) { |i| Array(Char).new }
  crates_drawing.each do |line|
    (1..line.size).step(by: 4) do |x|
      if line[x].letter?
        crates_arrangment[x//4].push line[x]
      end
    end
  end
  # Reverse stacks
  crates_arrangment.each &.reverse!

  # Read moves
  file.each_line do |line|
    split_move = line.split
    n_crates = split_move[1].to_i
    src = split_move[3].to_i - 1
    dst = split_move[5].to_i - 1
    n_crates.times do
      crates_arrangment[dst].push crates_arrangment[src].pop
    end
  end
  crates_arrangment.each { |x| print x.last }
  puts
end
