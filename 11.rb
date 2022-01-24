def valid?(password)
  straights = 0
  doubles = []
  p = nil
  l = nil
  password.each_char do |c|
    return false if %w[i o l].include?(c)
    doubles << c if l == c unless doubles.include?(c)
    straights += 1 if l && p && c.ord == l.ord + 1 && l.ord == p.ord + 1
    p = l
    l = c
  end
  straights >= 1 && doubles.size >= 2
end

ps = (ARGV.first || "hxbxwxba").succ
ps = ps.succ until valid?(ps)
puts ps
