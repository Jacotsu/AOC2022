File.open("input.txt") do |file|
  msg = file.gets_to_end
  (0..msg.size-14).each do |i|
    if msg[i..i+13].chars.uniq!.size == 14
      puts i + 14
      break
    end
  end
end
