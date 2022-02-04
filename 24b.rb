def subset_sums(ints, target)
  # meh. it's easier to wait 40 seconds than to figure out how to
  # implement this using dynamic programming :P
  (1..ints.size).map { |c| ints.combination(c).select { _1.sum == target } }.flatten(1)
end

weights = ARGF.each_line.map(&:to_i)
raise "not divisible by 4" unless weights.sum % 4 == 0
target = weights.sum / 4
part1 = subset_sums(weights, target)
print "#{part1.size} ways to build the first fourth..."

# sort by size and then QE, so the first candidate where part 2 splits twice is good
part1.sort_by! { |combo| [combo.size, combo.inject(:*)] }
puts "sorted."

part1.each do |combo1|
  sub1 = weights - combo1
  subset_sums(sub1, target).each do |combo2|
    sub2 = sub1 - combo2
    if subset_sums(sub2, target).any?
      puts combo1.inject(:*)
      exit
    end
  end
end
