def nice?(str)
  return false if %w[ab cd pq xy].any? { |naughty| str.include?(naughty) }
  return false unless str =~ /(.)\1/
  str.scan(/[aeiou]/).size >= 3
end

puts ARGF.each_line.count { |line| nice?(line) }
