display = Array(Char).new 6*40, '.'

def draw_pixel(display, s_pos, ticks)
  if (s_pos - (ticks % 40)).abs < 2
    display[ticks] = '#'
  end
end

def render(display)
  display.each_slice(40) do |x|
    puts x.join
  end
  puts
end

File.open("input.txt") do |file|
  reg_x = sprite_position = 1
  clock_ticks = 0

  file.each_line do |line|
    cmd = line.split
    draw_pixel display, sprite_position, clock_ticks
    case cmd[0]
    when "noop"
      clock_ticks += 1
    when "addx"
      clock_ticks += 1
      draw_pixel display, sprite_position, clock_ticks
      clock_ticks += 1
      reg_x += cmd[1].to_i
      sprite_position = reg_x % 40
    end
  end
  render display
end
