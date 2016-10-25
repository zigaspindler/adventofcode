# --- Part Two ---

# You just finish implementing your winning light pattern when you realize you mistranslated Santa's message from Ancient Nordic Elvish.

# The light grid you bought actually has individual brightness controls; each light can have a brightness of zero or more. The lights all start at zero.

# The phrase turn on actually means that you should increase the brightness of those lights by 1.

# The phrase turn off actually means that you should decrease the brightness of those lights by 1, to a minimum of zero.

# The phrase toggle actually means that you should increase the brightness of those lights by 2.

# What is the total brightness of all lights combined after following Santa's instructions?

# For example:

# turn on 0,0 through 0,0 would increase the total brightness by 1.
# toggle 0,0 through 999,999 would increase the total brightness by 2000000.

@lights = Array.new(1000) { Array.new(1000, 0) }

def execute_command(command, start, finish)
  x1, y1 = start.split(',').map { |i| i.to_i }
  x2, y2 = finish.split(',').map { |i| i.to_i }
  for x in x1..x2 do
    for y in y1..y2 do
      send command, x, y
    end
  end
end

def turn_on(x, y)
  @lights[x][y] += 1
end

def turn_off(x, y)
  @lights[x][y] -= 1 if @lights[x][y] > 0
end

def toggle(x, y)
  @lights[x][y] += 2
end

File.open('input.txt', 'r') do |input|
  while (line = input.gets)
    commands = line.chomp.split ' '
    if commands[0] == 'turn'
      execute_command("#{commands[0]}_#{commands[1]}", commands[2], commands[4])
    else
      execute_command(commands[0], commands[1], commands[3])
    end
  end
end

puts @lights.inject(:+).inject(:+)
