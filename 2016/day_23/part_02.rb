# --- Part Two ---

# The safe doesn't open, but it does make several angry noises to express its frustration.

# You're quite sure your logic is working correctly, so the only other thing is... you check the painting again. As it turns out, colored eggs are still eggs. Now you count 12.

# As you run the program with this new input, the prototype computer begins to overheat. You wonder what's taking so long, and whether the lack of any instruction more powerful than "add one" has anything to do with it. Don't bunnies usually multiply?

# Anyway, what value should actually be sent to the safe?

@registers = { a: 0, b: 0, c: 0, d: 0 }
@position = 0
@instructions = [{ instruction: 'cpy', args: ['12', 'a'] }]

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
  if (number?(args[0]) && args[0].to_i != 0) || @registers[args[0].to_sym] != 0
    @position += number?(args[1]) ? args[1].to_i : @registers[args[1].to_sym]
  else
    @position += 1
  end
end

def tgl(args)
  target = @position + @registers[args[0].to_sym]
  @position += 1

  return unless @instructions[target]

  case @instructions[target][:instruction]
  when 'inc'
    @instructions[target][:instruction] = 'dec'
  when 'dec', 'tgl'
    @instructions[target][:instruction] = 'inc'
  when 'jnz'
    @instructions[target][:instruction] = 'cpy'
  when 'cpy'
    @instructions[target][:instruction] = 'jnz'
  end
end

def mlt
  @registers[:a] = @registers[:b] * @registers[:d]
  @registers[:c] = 0
  @registers[:d] = 0
  @position += 6
end

File.readlines('input.txt').each do |line|
  args = line.chomp.split
  cmd = args.shift
  @instructions << { instruction: cmd, args: args }
end

while @position < @instructions.length
  if @position == 4 # find hot loop
    mlt
  else
    send(@instructions[@position][:instruction], @instructions[@position][:args])
  end
end

p @registers[:a]
