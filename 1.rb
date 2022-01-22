puts ARGF.gets.chars.reduce(0) { |sum, c| sum + [1, -1, 0]["()".index(c) || 2] }
