LIMIT = 1000000
target = ARGV.first&.to_i || 33100000

houses = [0] * LIMIT
(1...LIMIT).each do |elf|
  n = elf
  while n < houses.size
    houses[n] += elf * 10
    n += elf
  end
end

puts houses.index { |p| p >= target } || -houses.last
