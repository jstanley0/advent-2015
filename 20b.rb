LIMIT = 1000000
target = ARGV.first&.to_i || 33100000

houses = [0] * LIMIT
(1...LIMIT).each do |elf|
  n = elf
  m = 50
  while n < houses.size && m > 0
    houses[n] += elf * 11
    n += elf
    m -= 1
  end
end

puts houses.index { |p| p >= target } || -houses.last
