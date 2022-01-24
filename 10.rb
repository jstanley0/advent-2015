def look_say(str)
  str.chars.slice_when{_1 != _2}.map{ "#{_1.size}#{_1[0]}" }.join
end

s = ARGV[0] || "1113122113"
n = ARGV[1]&.to_i || 40
n.times { s = look_say(s) }
puts s.size
