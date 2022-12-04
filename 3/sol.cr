def get_priority(item : Char): Int32
  if item.ascii_lowercase?
    item.ord - 96
  else
    item.ord - 38
  end
end


File.open("input.txt") do |file|
  misplaced_items = Array(Char).new
  file.each_line do |line|
    compartment_1 = line[..line.size//2-1].each_char.to_set
    compartment_2 = line[line.size//2..].each_char.to_set
    misplaced_items += (compartment_1 & compartment_2).to_a
  end
  puts misplaced_items.reduce 0 {|acc, item| acc + get_priority item}
end
