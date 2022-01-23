class Gate
  def initialize(desc)
    input, @output = desc.strip.split(" -> ")
    @args = input.split
  end

  def val(elem, vars)
    if elem =~ /\d+/
      elem.to_i
    else
      vars[elem]
    end
  end

  def evaluate(vars)
    output = case @args.size
    when 1
      val(@args[0], vars)
    when 2
      v = val(@args[1], vars)
      if v
        case @args[0]
        when 'NOT'
          ~v & 0xffff
        else
          raise "unexpected unary operator #{@args[0]}"
        end
      end
    when 3
      vl = val(@args[0], vars)
      vr = val(@args[2], vars)
      if vl && vr
        case @args[1]
        when 'AND'
          vl & vr
        when 'OR'
          vl | vr
        when 'LSHIFT'
          (vl << vr) & 0xffff
        when 'RSHIFT'
          vl >> vr
        else
          raise "unexpected binary operator #{@args[1]}"
        end
      end
    else
      raise "unexpected arity: #{@args.inspect}" unless @args.empty?
    end
    vars[@output] = output
  end
end

gates = ARGF.each_line.map { |line| Gate.new(line) }

vars = {}
until gates.empty?
  i = gates.index { |gate| gate.evaluate(vars) }
  raise "indeterminate" unless i
  gates.delete_at i
end

puts vars['a']
