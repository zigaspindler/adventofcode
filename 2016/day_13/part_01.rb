# --- Day 13: A Maze of Twisty Little Cubicles ---

# You arrive at the first floor of this new building to discover a much less welcoming environment than the shiny atrium of the last one. Instead, you are in a maze of twisty little cubicles, all alike.

# Every location in this area is addressed by a pair of non-negative integers (x,y). Each such coordinate is either a wall or an open space. You can't move diagonally. The cube maze starts at 0,0 and seems to extend infinitely toward positive x and y; negative values are invalid, as they represent a location outside the building. You are in a small waiting area at 1,1.

# While it seems chaotic, a nearby morale-boosting poster explains, the layout is actually quite logical. You can determine whether a given x,y coordinate will be a wall or an open space using a simple system:

# Find x*x + 3*x + 2*x*y + y + y*y.
# Add the office designer's favorite number (your puzzle input).
# Find the binary representation of that sum; count the number of bits that are 1.
# If the number of bits that are 1 is even, it's an open space.
# If the number of bits that are 1 is odd, it's a wall.
# For example, if the office designer's favorite number were 10, drawing walls as # and open spaces as ., the corner of the building containing 0,0 would look like this:

#   0123456789
# 0 .#.####.##
# 1 ..#..#...#
# 2 #....##...
# 3 ###.#.###.
# 4 .##..#..#.
# 5 ..##....#.
# 6 #...##.###
# Now, suppose you wanted to reach 7,4. The shortest route you could take is marked as O:

#   0123456789
# 0 .#.####.##
# 1 .O#..#...#
# 2 #OOO.##...
# 3 ###O#.###.
# 4 .##OO#OO#.
# 5 ..##OOO.#.
# 6 #...##.###
# Thus, reaching 7,4 would take a minimum of 11 steps (starting from your current location, 1,1).

# What is the fewest number of steps required for you to reach 31,39?

FAVORITE_NUMBER = 1364
START = [1, 1]
GOAL = [31, 39]

def heuristic(current)
  (currentx - GOAL[0]).abs + (currenty - GOAL[1]).abs
end

def open?(node)
  x, y = node.to_a
  return false if x < 0 or y < 0
  (x * x + 3 * x + 2 * x * y + y + y * y + FAVORITE_NUMBER).to_s(2).gsub('0', '').length.even?
end

def neighbors(node)
  n = []
  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |a|
    neighbor = Node.new(node.x + a[0], node.y + a[1], node.g_score + 1)
    n << neighbor if open?(neighbor)
  end
  n
end

def a_star(start_node, goal)
  closed_set = []
  open_set = [start_node]
  came_from = {}

  while open_set.any?
    current = open_set.sort_by!{ |n| n.f_score }.shift
    closed_set << current.to_a

    return reconstruct_path(came_from, current) if current.to_a == goal

    neighbors(current).each do |neighbor|
      next if closed_set.include?(neighbor.to_a)
      previous = open_set.find_index{ |n| n.to_a == neighbor.to_a }
      if previous.nil?
        open_set << neighbor
        came_from[neighbor.to_s] = current
      elsif neighbor.g_score < open_set[previous].g_score
        came_from[neighbor.to_s] = current
        open_set[previous] = current
      end
    end
  end

  return []
end

def reconstruct_path(came_from, current)
  path = [current.to_a]
  while came_from.keys.include?(current.to_s)
    current = came_from[current.to_s]
    path << current.to_a
  end
  path
end

class Node
  def initialize(x, y, g = 0)
    @x = x
    @y = y
    @g = g
  end

  def x
    @x
  end

  def y
    @y
  end

  def g_score
    @g
  end

  def to_s
    "#{@x}_#{@y}"
  end

  def to_a
    [@x, @y]
  end

  def f_score
    @f_score ||= @g + (@x - GOAL[0]).abs + (@y - GOAL[1]).abs
  end
end

p a_star(Node.new(START[0], START[1]), GOAL).count - 1

