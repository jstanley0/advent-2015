SEARCH = { children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0, goldfish: 5, trees: 3, cars: 2, perfumes: 1 }.freeze

ARGF.each_line do |line|
  sue, attrs = line.split(': ', 2)
  attrs = attrs.split(', ').map { |a| a.split(': ') }.to_h.tap { |p| p.transform_values! { |v| v.to_i } }
  puts sue if attrs.keys.all? { |k| attrs[k] == SEARCH[k.to_sym] }
end
