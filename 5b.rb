puts ARGF.each_line.count { |line| line =~ /(..).*\1/ && line =~ /(.).\1/ }
