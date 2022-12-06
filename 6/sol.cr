File.open("input.txt") do |file|
  msg = file.gets_to_end
  (0..msg.size-4).each do |i|
    if msg[i..i+3].chars.uniq!.size == 4
      puts i + 4
      break
    end
  end
end
