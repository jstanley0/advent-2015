puts ARGF.each_line.map { |line| line.strip.size - eval(line).size }.sum
