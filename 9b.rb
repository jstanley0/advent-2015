graph = {}
ARGF.each_line do |line|
  nodes, dist = line.split(' = ')
  nodes = nodes.split(' to ')
  dist = dist.to_i
  graph[nodes.first] ||= {}
  graph[nodes.first][nodes.last] = dist
  graph[nodes.last] ||= {}
  graph[nodes.last][nodes.first] = dist
end

def find_worst_path(graph, from_city, visited_cities = [], dist_so_far = 0)
  visited_cities = visited_cities + [from_city]
  return dist_so_far if visited_cities.size == graph.keys.size

  graph[from_city].map { |next_hop, dist|
    find_worst_path(graph, next_hop, visited_cities, dist_so_far + dist) unless visited_cities.include?(next_hop)
  }.compact.max
end

puts graph.keys.map { |city| find_worst_path(graph, city) }.compact.max
