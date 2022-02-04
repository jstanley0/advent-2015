def subset_sums(ints, target, subrange = 1..ints.size)
  subrange.map { |c| ints.combination(c).select { _1.sum == target } }.flatten(1)
end

weights = ARGF.each_line.map(&:to_i)
raise "not divisible by 3" unless weights.sum % 3 == 0
target = weights.sum / 3
(1..weights.size).each do |s|
  subset_sums(weights, target, s..s).sort_by { _1.inject(:*) }.each do |combo|
    if subset_sums(weights - combo, target).any?
      puts combo.inject(:*)
      exit
    end
  end
end
