puts ARGF.each_line.map { |line| line.strip.inspect.size - line.strip.size }.sum
