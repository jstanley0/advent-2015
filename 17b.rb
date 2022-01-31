eggnog = ARGV.delete_at(1)&.to_i || 25
containers = ARGF.each_line.map { _1.to_i }

counts = Hash.new(0)
(1 << containers.size).times do |bits|
  total = 0
  n = 0
  containers.each_with_index do |volume, i|
    if bits[i] != 0
      total += volume
      n += 1
    end
  end
  counts[n] += 1 if total == eggnog
end
puts counts[counts.keys.min]
