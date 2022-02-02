Inst = Struct.new(:opcode, :args)

program = ARGF.each_line.map { |line|
  opcode, args = line.strip.split(' ', 2)
  args = args.split(', ')
  Inst.new(opcode, args)
}

def run(program)
  regs = { 'a' => 1, 'b' => 0 }
  ip = 0
  while (0...program.size).include?(ip)
    inst = program[ip]
    puts "#{ip}. a=#{regs['a']} b=#{regs['b']}  #{inst.opcode} #{inst.args[0]} #{inst.args[1]}"
    case inst.opcode
    when 'hlf'
      regs[inst.args[0]] /= 2
    when 'tpl'
      regs[inst.args[0]] *= 3
    when 'inc'
      regs[inst.args[0]] += 1
    when 'jmp'
      ip += inst.args[0].to_i - 1
    when 'jie'
      ip += inst.args[1].to_i - 1 if regs[inst.args[0]].even?
    when 'jio'
      ip += inst.args[1].to_i - 1 if regs[inst.args[0]] == 1
    else
      raise "bad opcode #{inst.opcode}"
    end
    ip += 1
  end
  pp regs
end

run program
