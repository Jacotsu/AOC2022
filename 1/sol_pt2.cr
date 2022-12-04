File.open("input.txt") do |file|
  max =  Array(Int64).new 3, 0
  current_max = 0
  file.each_line do |line|
    if line.empty?
      # Sort in place
      max.sort!
      max.each.with_index { |x, i|
        if x < current_max
          max[i] = current_max
          break
        end
      }
      current_max = 0
    else
      current_max += line.to_i64
    end
  end
  puts max.sum
end
