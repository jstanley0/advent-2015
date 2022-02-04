def find_sequence(row, col)
  n = 1
  y0 = 1
  loop do
    x = 1
    y0.downto(1) do |y|
      return n if x == col && y == row
      n += 1
      x += 1
    end
    y0 += 1
  end
end

n = find_sequence(2947, 3029)
puts (20151125 * 252533.pow(n, 33554393)) % 33554393
