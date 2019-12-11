# --- Part Two ---
# You're not sure what it's trying to paint, but it's definitely not a registration identifier. The Space Police are getting impatient.

# Checking your external ship cameras again, you notice a white panel marked "emergency hull painting robot starting panel". The rest of the panels are still black, but it looks like the robot was expecting to start on a white panel, not a black one.

# Based on the Space Law Space Brochure that the Space Police attached to one of your windows, a valid registration identifier is always eight capital letters. After starting the robot on a single white panel instead, what registration identifier does it paint on your hull?

require '../lib/intcode'

module Direction
  UP = 0
  LEFT = 1
  DOWN = 2
  RIGHT = 3
end

opcodes = File.read('input.txt').strip.split(',').map(&:to_i)

input = Queue.new
output = Queue.new

worker = Thread.new do
  Intcode.new(opcodes, input: input, output: output).run
end

current_position = [0,0]
panels = {}
panels[current_position.to_s] = 1
direction = Direction::UP

min = [0, 0]
max = [0, 0]

while worker.alive?
  input.push(panels[current_position.to_s] || 0)
  panels[current_position.to_s] = output.pop
  
  turn = output.pop == 0 ? 1 : -1

  direction = (direction + turn) % 4

  case direction
  when Direction::UP
    current_position[0] += 1
    max[0] = [current_position[0], max[0]].max
  when Direction::LEFT
    current_position[1] -= 1
    min[1] = [current_position[1], min[1]].min
  when Direction::DOWN
    current_position[0] -= 1
    min[0] = [current_position[0], min[0]].min
  else
    current_position[1] += 1
    max[1] = [current_position[1], max[1]].max
  end
end

for i in max[0].downto(min[0]) do
  for j in min[1]..max[1] do
    color = panels[[i, j].to_s] || 0
    char = color == 1 ? '#' : ' '

    print char
  end
  print "\n"
end
