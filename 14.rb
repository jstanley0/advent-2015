Deer = Struct.new(:name, :speed, :flight_time, :rest_time, :x, :flying, :state_time, :score) do
  def initialize(...)
    super
    self.x = 0
    self.flying = true
    self.state_time = flight_time
    self.score = 0
  end
end

time = ARGV.delete_at(1)&.to_i || 1000
deer = ARGF.each_line.map { |line|
  if line =~ /([A-Za-z]+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds/
    Deer.new($1, $2.to_i, $3.to_i, $4.to_i)
  end
}.compact

time.times do
  deer.each do |d|
    d.x += d.speed if d.flying
    d.state_time -= 1
    if d.state_time == 0
      d.flying = !d.flying
      d.state_time = (d.flying ? d.flight_time : d.rest_time)
    end
  end
  max_x = deer.max_by(&:x).x
  deer.each { |d| d.score += 1 if d.x == max_x }
end

puts deer.map(&:x).max
puts deer.map(&:score).max
