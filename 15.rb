ingredients = {}
ARGF.each_line do |line|
  ingredient, attrs = line.split(':')
  ingredients[ingredient] = (attrs.split(',').map(&:split)).to_h.tap do |h|
    h.delete('calories') # for now
    h.transform_values! { |v| v.to_i }
  end
end
pp ingredients

require 'z3'
opt = Z3::Optimize.new

amounts = ingredients.keys.map { Z3::Int(_1) }
properties = ingredients.first.last.keys.map { Z3::Int(_1) }
score = Z3::Int("score")

opt.assert(amounts.sum == 100)
properties.each do |property|
  int_sum = Z3::Int("#{property.to_s}_int")
  opt.assert(int_sum == amounts.map { |amount| amount * ingredients[amount.to_s][property.to_s] }.sum)
  opt.assert(property == Z3.IfThenElse(int_sum > 0, int_sum, 0))
end

opt.assert(score == properties.inject(:*))
opt.maximize(score)

if opt.satisfiable?
  puts opt.model.to_s
else
  puts "no solution :("
end
