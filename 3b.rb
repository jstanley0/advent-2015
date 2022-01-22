presents = {}
deliver_to = ->(x, y) do
  presents[[x, y]] ||= 0
  presents[[x, y]] += 1
end

x, y = [0, 0], [0, 0]
(0..1).each { |i| deliver_to.(x[i], y[i]) }
ARGF.gets.chars.each_with_index do |c, n|
  i = n & 1
  case c
  when '^'
    y[i] -= 1
  when '<'
    x[i] -= 1
  when 'v'
    y[i] += 1
  when '>'
    x[i] += 1
  end
  deliver_to.(x[i], y[i])
end

puts presents.size
