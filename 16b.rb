EXACT = { 'children' => 3, 'samoyeds' => 2, 'akitas' => 0, 'vizslas' => 0, 'cars' => 2, 'perfumes' => 1 }.freeze
LOWER = { 'cats' => 7, 'trees' => 3 }.freeze
UPPER = { 'pomeranians' => 3, 'goldfish' => 5 }.freeze

ARGF.each_line do |line|
  sue, attrs = line.split(': ', 2)
  attrs = attrs.split(', ').map { |a| a.split(': ') }.to_h.tap { |p| p.transform_values! { |v| v.to_i } }
  puts sue if attrs.keys.all? { |k|
    (!EXACT.include?(k) || attrs[k] == EXACT[k]) &&
    (!LOWER.include?(k) || attrs[k] > LOWER[k]) &&
    (!UPPER.include?(k) || attrs[k] < UPPER[k])
  }
end
