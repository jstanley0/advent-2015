require 'set'

reductions = {}

loop do
  line = ARGF.gets.strip
  break if line.empty?

  reduced, thing = line.split(' => ')
  reductions[thing] = reduced
end

molecule = ARGF.gets.strip
$best = 1e9

def reduce(molecule, reductions, steps)
  reductions.each do |thing, reduced|
    rc = molecule.sub(thing, reduced)
    next if rc == molecule

    if rc == 'e'
      if steps < $best
        puts "found a solution in #{steps} steps"
        $best = steps
      end
    elsif steps < $best
      reduce(rc, reductions, steps + 1)
    end
  end
end

reduce(molecule, reductions, 1)
