File.open("input.txt") do |file|
  grid = Array(Array(Int32)).new
  file.each_line do |line|
    grid.push(line.each_char.to_a.map { |x| x.to_i })
  end
  size = grid[0].size
  visibility_matrix = Array(Array(Int32)).new(size) { Array(Int32).new size, 0 }

  previous_tree = -1
  check_visibility = ->(i : Int32, j : Int32) {
    elem = grid[i][j]
    if previous_tree < elem
      visibility_matrix[i][j] = 1
      previous_tree = elem
    end
  }

  (0...size).each do |i|
    (0...size).each { |j| check_visibility.call i, j }
    previous_tree = -1
    (0...size).reverse_each { |j| check_visibility.call i, j }
    previous_tree = -1
    (0...size).each { |j| check_visibility.call j, i }
    previous_tree = -1
    (0...size).reverse_each { |j| check_visibility.call j, i }
    previous_tree = -1
  end

  puts visibility_matrix.sum.sum
end
