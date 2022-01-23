lights = (0...1000).map { [0] * 1000 }

def map_lights(lights, coords)
  (coords[0]..coords[2]).each do |x|
    (coords[1]..coords[3]).each do |y|
      lights[y][x] = yield lights[y][x]
    end
  end
end

ARGF.each_line do |line|
  coords = line.scan(/\d+/).map(&:to_i)
  if line.start_with?("turn on")
    map_lights(lights, coords) { |val| val + 1 }
  elsif line.start_with?("turn off")
    map_lights(lights, coords) { |val| [0, val - 1].max }
  elsif line.start_with?("toggle")
    map_lights(lights, coords) { |val| val + 2 }
  end
end

puts lights.map(&:sum).sum

