puts ARGF.lines.reduce(0) { |total, line|
  dims = line.split('x').map(&:to_i)
  areas = dims.combination(2).map { _1 * _2 }
  total + 2 * areas.sum + areas.min
}
