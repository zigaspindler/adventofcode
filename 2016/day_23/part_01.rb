# --- Day 23: Safe Cracking ---

# This is one of the top floors of the nicest tower in EBHQ. The Easter Bunny's private office is here, complete with a safe hidden behind a painting, and who wouldn't hide a star in a safe behind a painting?

# The safe has a digital screen and keypad for code entry. A sticky note attached to the safe has a password hint on it: "eggs". The painting is of a large rabbit coloring some eggs. You see 7.

# When you go to type the code, though, nothing appears on the display; instead, the keypad comes apart in your hands, apparently having been smashed. Behind it is some kind of socket - one that matches a connector in your prototype computer! You pull apart the smashed keypad and extract the logic circuit, plug it into your computer, and plug your computer into the safe.

# Now, you just need to figure out what output the keypad would have sent to the safe. You extract the assembunny code from the logic chip (your puzzle input).
# The code looks like it uses almost the same architecture and instruction set that the monorail computer used! You should be able to use the same assembunny interpreter for this as you did there, but with one new instruction:

# tgl x toggles the instruction x away (pointing at instructions like jnz does: positive means forward; negative means backward):

# For one-argument instructions, inc becomes dec, and all other one-argument instructions become inc.
# For two-argument instructions, jnz becomes cpy, and all other two-instructions become jnz.
# The arguments of a toggled instruction are not affected.
# If an attempt is made to toggle an instruction outside the program, nothing happens.
# If toggling produces an invalid instruction (like cpy 1 2) and an attempt is later made to execute that instruction, skip it instead.
# If tgl toggles itself (for example, if a is 0, tgl a would target itself and become inc a), the resulting instruction is not executed until the next time it is reached.
# For example, given this program:

# cpy 2 a
# tgl a
# tgl a
# tgl a
# cpy 1 a
# dec a
# dec a
# cpy 2 a initializes register a to 2.
# The first tgl a toggles an instruction a (2) away from it, which changes the third tgl a into inc a.
# The second tgl a also modifies an instruction 2 away from it, which changes the cpy 1 a into jnz 1 a.
# The fourth line, which is now inc a, increments a to 3.
# Finally, the fifth line, which is now jnz 1 a, jumps a (3) instructions ahead, skipping the dec a instructions.
# In this example, the final value in register a is 3.

# The rest of the electronics seem to place the keypad entry (the number of eggs, 7) in register a, run the code, and then send the value left in register a to the safe.

# What value should be sent to the safe?

@registers = { a: 0, b: 0, c: 0, d: 0 }
@position = 0
@instructions = [{ instruction: 'cpy', args: ['7', 'a'] }]

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

File.readlines('input.txt').each do |line|
  args = line.chomp.split
  cmd = args.shift
  @instructions << { instruction: cmd, args: args }
end

while @position < @instructions.length
  send(@instructions[@position][:instruction], @instructions[@position][:args])
end

p @registers[:a]
