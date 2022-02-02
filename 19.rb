require 'set'

rules = Hash.new { |h, k| h[k] = [] }

loop do
  line = ARGF.gets.strip
  break if line.empty?

  el, rule = line.split(' => ')
  rules[el] << rule
end

molecule = ARGF.gets.strip
replacements = Set.new

rules.each do |k, v|
  off = 0
  while (pos = molecule.index(k, off))
    v.each do |sub|
      replacements << molecule[0...pos] + sub + molecule[pos + k.size..]
    end
    off = pos + 1
  end
end

puts replacements.size
