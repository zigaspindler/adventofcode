# --- Part Two ---

# The unknown benefactor is very thankful for releasi-- er, helping little Jane Marie with her computer. Definitely not to distract you, what is the value in register b after the program is finished executing if register a starts as 1 instead?

@a = 1
@b = 0
@position = 0
instructions = []

def inc(args)
  eval "@#{args[:register]} += 1"
  @position += 1
end

def jio(args)
  eval "@position += @#{args[:register]} == 1 ? #{args[:offset]} : 1"
end

def jie(args)
  eval "@position += @#{args[:register]} % 2 == 0 ? #{args[:offset]} : 1"
end

def hlf(args)
  eval "@#{args[:register]} /= 2"
  @position += 1
end

def tpl(args)
  eval "@#{args[:register]} *= 3"
  @position += 1
end

def jmp(args)
  eval "@position += #{args[:register]}"
end

File.open('input.txt', 'r').each_line do |line|
  command, offset = line.chomp.split ', '
  instruction, register = command.split ' '
  instructions << { instruction: instruction, register: register, offset: offset.to_i }
end

while @position < instructions.length
  send(instructions[@position][:instruction], instructions[@position])
end

puts @b
