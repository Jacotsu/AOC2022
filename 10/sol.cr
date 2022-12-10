def update_strength(str_arr, ticks, reg)
  if {20, 60, 100, 140, 180, 220}.any?(ticks)
    puts "#{ticks} #{reg} #{reg*ticks}"
    str_arr.push reg*ticks
  end
end

File.open("input.txt") do |file|
  reg_x = 1
  clock_ticks = 1
  sig_strengths = Array(Int32).new 6
  file.each_line do |line|
    cmd = line.split
    case cmd[0]
    when "noop"
      clock_ticks += 1
    when "addx"
      clock_ticks += 1
      update_strength sig_strengths, clock_ticks, reg_x
      clock_ticks += 1
      reg_x += cmd[1].to_i
    end
    update_strength sig_strengths, clock_ticks, reg_x
  end
  puts sig_strengths.sum
end
