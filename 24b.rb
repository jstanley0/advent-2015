def subset_sums(ints, target, subrange = 1..ints.size)
  subrange.map { |c| ints.combination(c).select { _1.sum == target } }.flatten(1)
end

weights = ARGF.each_line.map(&:to_i)
raise "not divisible by 4" unless weights.sum % 4 == 0
target = weights.sum / 4
(1..weights.size).each do |s|
  subset_sums(weights, target, s..s).sort_by { _1.inject(:*) }.each do |combo1|
    subset1 = weights - combo1
    subset_sums(subset1, target).each do |combo2|
      subset2 = subset1 - combo2
      if subset_sums(subset2, target).any?
        puts combo1.inject(:*)
        exit
      end
    end
  end
end
