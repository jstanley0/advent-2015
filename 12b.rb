require 'json'

def sum_document(json)
  if json.is_a?(Integer)
    json
  elsif json.is_a?(Array)
    json.map { sum_document(_1) }.sum
  elsif json.is_a?(Hash)
    json.values.map { sum_document(_1) }.sum
  else
    0
  end
end

ARGF.each_line do |line|
  puts sum_document(JSON.parse(line))
end
