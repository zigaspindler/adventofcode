# --- Part Two ---
# It turns out that this circuit is very timing-sensitive; you actually need to minimize the signal delay.

# To do this, calculate the number of steps each wire takes to reach each intersection; choose the intersection where the sum of both wires' steps is lowest. If a wire visits a position on the grid multiple times, use the steps value from the first time it visits that position when calculating the total value of a specific intersection.

# The number of steps a wire takes is the total number of grid squares the wire has entered to get to that location, including the intersection being considered. Again consider the example from above:

# ...........
# .+-----+...
# .|.....|...
# .|..+--X-+.
# .|..|..|.|.
# .|.-X--+.|.
# .|..|....|.
# .|.......|.
# .o-------+.
# ...........
# In the above example, the intersection closest to the central port is reached after 8+5+5+2 = 20 steps by the first wire and 7+6+4+3 = 20 steps by the second wire for a total of 20+20 = 40 steps.

# However, the top-right intersection is better: the first wire takes only 8+5+2 = 15 and the second wire takes only 7+6+2 = 15, a total of 15+15 = 30 steps.

# Here are the best steps for the extra examples from above:

# R75,D30,R83,U83,L12,D49,R71,U7,L72
# U62,R66,U55,R34,D71,R55,D58,R83 = 610 steps
# R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
# U98,R91,D20,R16,D67,R40,U7,R15,U6,R7 = 410 steps
# What is the fewest combined steps the wires must take to reach an intersection?

class Point
  attr_accessor :x, :y, :step, :distance

  def initialize(x, y, step)
    @x = x
    @y = y
    @step = step
    @distance = x.abs + y.abs
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def <=>(other)
    @step <=> other.step
  end
end

def get_path(instructions)
  path = []
  step = 0

  instructions.split(',').each do |ins|
    last = path.last || Point.new(0, 0, 0)
    count = ins[1..-1].to_i
    
    case ins[0]
    when 'U'
      path += up(count, last, step)
    when 'D'
      path += down(count, last, step)
    when 'L'
      path += left(count, last, step)
    when 'R'
      path += right(count, last, step)
    end

    step += count
  end

  path
end

def up(count, start, step)
  (1..count).map { |i| Point.new(start.x, start.y + i, step + i) }
end

def down(count, start, step)
  (1..count).map { |i| Point.new(start.x, start.y - i, step + i) }
end

def left(count, start, step)
  (1..count).map { |i| Point.new(start.x - i, start.y, step + i) }
end

def right(count, start, step)
  (1..count).map { |i| Point.new(start.x + i, start.y, step + i) }
end

a, b =  File.read('input.txt').strip.split("\n")

path_a = get_path(a).sort
path_b = get_path(b).sort

min = nil

path_a.each do |point_a|
  break if min && point_a.step > min

  path_b.each do |point_b|
    next unless point_a == point_b
    total_steps = point_a.step + point_b.step

    break if min && total_steps > min

    min = total_steps unless min

    min = [min, total_steps].min
  end
end

p min
