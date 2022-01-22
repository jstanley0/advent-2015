floor = 0
ARGF.gets.chars.each_with_index do |c, i|
  case c
  when '(' then floor += 1
  when ')' then floor -= 1
  end
  if floor < 0
    puts i + 1
    break
  end
end
