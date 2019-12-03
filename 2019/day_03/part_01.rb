# --- Day 3: Crossed Wires ---
# The gravity assist was successful, and you're well on your way to the Venus refuelling station. During the rush back on Earth, the fuel management system wasn't completely installed, so that's next on the priority list.

# Opening the front panel reveals a jumble of wires. Specifically, two wires are connected to a central port and extend outward on a grid. You trace the path each wire takes as it leaves the central port, one wire per line of text (your puzzle input).

# The wires twist and turn, but the two wires occasionally cross paths. To fix the circuit, you need to find the intersection point closest to the central port. Because the wires are on a grid, use the Manhattan distance for this measurement. While the wires do technically cross right at the central port where they both start, this point does not count, nor does a wire count as crossing with itself.

# For example, if the first wire's path is R8,U5,L5,D3, then starting from the central port (o), it goes right 8, up 5, left 5, and finally down 3:

# ...........
# ...........
# ...........
# ....+----+.
# ....|....|.
# ....|....|.
# ....|....|.
# .........|.
# .o-------+.
# ...........
# Then, if the second wire's path is U7,R6,D4,L4, it goes up 7, right 6, down 4, and left 4:

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
# These wires cross at two locations (marked X), but the lower-left one is closer to the central port: its distance is 3 + 3 = 6.

# Here are a few more examples:

# R75,D30,R83,U83,L12,D49,R71,U7,L72
# U62,R66,U55,R34,D71,R55,D58,R83 = distance 159
# R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
# U98,R91,D20,R16,D67,R40,U7,R15,U6,R7 = distance 135
# What is the Manhattan distance from the central port to the closest intersection?

def get_path(instructions)
  path = []

  instructions.split(',').each do |ins|
    last = path.last || [0, 0]
    count = ins[1..-1].to_i
    
    case ins[0]
    when 'U'
      path += up(count, last)
    when 'D'
      path += down(count, last)
    when 'L'
      path += left(count, last)
    when 'R'
      path += right(count, last)
    end
  end

  path
end

def up(count, start)
  (1..count).map { |i| [start[0], start[1] + i] }
end

def down(count, start)
  (1..count).map { |i| [start[0], start[1] - i] }
end

def left(count, start)
  (1..count).map { |i| [start[0] - i, start[1]] }
end

def right(count, start)
  (1..count).map { |i| [start[0] + i, start[1]] }
end

a, b =  File.read('input.txt').strip.split("\n")

path_a = get_path(a)
path_b = get_path(b)

intersections = path_a & path_b

closest = intersections.reduce(0) do |min, inter|
  dist = inter[0].abs + inter[1].abs

  if min == 0
    dist
  else
   dist < min ? dist : min
  end
end

p closest
