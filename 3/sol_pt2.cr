def get_priority(item : Char): Int32
  if item.ascii_lowercase?
    item.ord - 96
  else
    item.ord - 38
  end
end


File.open("input.txt") do |file|
  badges = Array(Char).new

  while true
    begin
      rucksack_1 = file.read_line.each_char.to_set
      rucksack_2 = file.read_line.each_char.to_set
      rucksack_3 = file.read_line.each_char.to_set
      badges += (rucksack_1 & rucksack_2 & rucksack_3).to_a
    rescue IO::EOFError
      break
    end
  end

  puts badges.reduce 0 {|acc, item| acc + get_priority item}
end
