def calc_score(grid, i, j) : Int32
  size = grid[0].size
  cur_elem = grid[i][j]

  check_visibility = ->(max_height : Int32, i : Int32, j : Int32) : Bool {
    elem = grid[i][j]
    if elem >= max_height
      return true
    else
      return false
    end
  }

  score = Array(Int32).new 4, 0
  (j+1...size).each { |z|
    score[0] += 1
    break if check_visibility.call cur_elem, i, z
  }
  (0...j).reverse_each { |z|
    score[1] += 1
    break if check_visibility.call cur_elem, i, z
  }
  (i+1...size).each { |z|
    score[2] += 1
    break if check_visibility.call cur_elem, z, j
  }
  (0...i).reverse_each { |z|
    score[3] += 1
    break if check_visibility.call cur_elem, z, j
  }
  return score.product
end



grid = Array(Array(Int32)).new

File.open("input.txt") do |file|
  file.each_line do |line|
    grid.push(line.each_char.to_a.map { |x| x.to_i })
  end
end


size = grid[0].size
max = 0
(1...size-1).each { |i|
  (1...size-1).each { |j|
    score = calc_score(grid, i, j)
    if score > max
      max = score
    end
  }
}
puts max
