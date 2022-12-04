File.open("input.txt") do |file|
  full_overlaps = 0
  file.each_line do |line|
    pairs = line.split ','
    first_elf_range = (pairs[0].split '-').map { |i| i.to_i}
    second_elf_range = (pairs[1].split '-').map { |i| i.to_i}
    if (first_elf_range[0] <= second_elf_range[0] && \
        first_elf_range[1] >= second_elf_range[1]) || \
        (first_elf_range[0] >= second_elf_range[0] && \
        first_elf_range[1] <= second_elf_range[1])
      full_overlaps += 1
    end
  end
  puts full_overlaps
end
