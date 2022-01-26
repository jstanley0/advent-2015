presents = Hash.new(0)
deliver_to = ->(x, y) do
  presents[[x, y]] += 1
end

x, y = 0, 0
ARGF.gets.each_char do |c|
  deliver_to.(x, y)
  case c
  when '^'
    y -= 1
  when '<'
    x -= 1
  when 'v'
    y += 1
  when '>'
    x += 1
  end
end
deliver_to.(x, y)
puts presents.size
