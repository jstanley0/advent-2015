def subset_sums(ints, target)
  # todo write this better
  (1..ints.size).map { |c| ints.combination(c).select { _1.sum == target } }.flatten(1)
end

weights = ARGF.each_line.map(&:to_i)
raise "not divisible by 3" unless weights.sum % 3 == 0
target = weights.sum / 3
part1 = subset_sums(weights, target)
print "#{part1.size} ways to build the first third..."

# sort by size and then QE, so the first candidate where part 2 splits is good
part1.sort_by! { |combo| [combo.size, combo.inject(:*)] }
puts "sorted."

part1.each do |combo1|
  if subset_sums(weights - combo1, target).any?
    puts combo1.inject(:*)
    break
  end
end
