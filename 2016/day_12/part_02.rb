# --- Part Two ---

# As you head down the fire escape to the monorail, you notice it didn't start; register c needs to be initialized to the position of the ignition key.

# If you instead initialize register c to be 1, what value is now left in register a?

@registers = { a: 0, b: 0, c: 1, d: 0 }
@position = 0
instructions = []

def number?(arg)
  arg.scan(/(\d+)/).any?
end

def inc(args)
  @registers[args[0].to_sym] += 1
  @position += 1
end

def dec(args)
  @registers[args[0].to_sym] -= 1
  @position += 1
end

def cpy(args)
  @registers[args[1].to_sym] = number?(args[0]) ? args[0].to_i : @registers[args[0].to_sym]
  @position += 1
end

def jnz(args)
  if (number?(args[0]) and args[0].to_i != 0) or @registers[args[0].to_sym] != 0
    @position += args[1].to_i
  else
    @position += 1
  end
end

File.readlines('input.txt').each do |line|
  args = line.chomp.split
  cmd = args.shift
  instructions << { instruction: cmd, args: args }
end

while @position < instructions.length
  send(instructions[@position][:instruction], instructions[@position][:args])
end

p @registers[:a]
