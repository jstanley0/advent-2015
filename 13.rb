happymap = Hash.new { |h, k| h[k] = {} }

ARGF.each_line do |line|
  if line =~ /([A-Za-z]+) would (gain|lose) (\d+) happiness units by sitting next to ([A-Za-z]+)/
    happymap[$1][$4] = $3.to_i * ($2 == 'gain' ? 1 : -1)
  end
end

def score(happymap, order)
  (0...order.size).map { |i|
    happymap[order[i]][order[(i + 1) % order.size]] + happymap[order[i]][order[(i - 1) % order.size]]
  }.sum
end

pp happymap
best = happymap.keys.permutation.max_by { |order| score(happymap, order) }

puts best.inspect
puts score(happymap, best)
