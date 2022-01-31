eggnog = ARGV.delete_at(1)&.to_i || 25
containers = ARGF.each_line.map { _1.to_i }

# laaaaazy
match = 0
(1 << containers.size).times do |bits|
  total = 0
  containers.each_with_index do |volume, i|
    total += volume if bits[i] != 0
  end
  match += 1 if total == eggnog
end
puts match
