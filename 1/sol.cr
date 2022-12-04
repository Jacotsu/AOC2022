File.open("input.txt") do |file|
  max = 0
  current_max = 0
  file.each_line do |line|
    if line.empty?
      max = current_max > max ? current_max : max
      current_max = 0
    else
      current_max += line.to_i64
    end
  end
  puts max
end
