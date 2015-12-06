# --- Day 6: Probably a Fire Hazard ---

# Because your neighbors keep defeating you in the holiday house decorating contest year after year, you've decided to deploy one million lights in a 1000x1000 grid.

# Furthermore, because you've been especially nice this year, Santa has mailed you instructions on how to display the ideal lighting configuration.

# Lights in your grid are numbered from 0 to 999 in each direction; the lights at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions include whether to turn on, turn off, or toggle various inclusive ranges given as coordinate pairs. Each coordinate pair represents opposite corners of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers to 9 lights in a 3x3 square. The lights all start turned off.

# To defeat your neighbors this year, all you have to do is set up your lights by doing the instructions Santa sent you in order.

# For example:

# turn on 0,0 through 999,999 would turn on (or leave on) every light.
# toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
# turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
# After following the instructions, how many lights are lit?

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
  @lights[x][y] = 1
end

def turn_off(x, y)
  @lights[x][y] = 0
end

def toggle(x, y)
  @lights[x][y] = (@lights[x][y] + 1) % 2
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
