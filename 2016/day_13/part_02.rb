# --- Part Two ---

# How many locations (distinct x,y coordinates, including your starting location) can you reach in at most 50 steps?

FAVORITE_NUMBER = 1364
START = [1, 1]

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

def search
  locations = []
  open_set = [Node.new(START[0], START[1])]

  while open_set.any?
    current = open_set.shift
    if current.g_score <= 50 and locations.find_index{ |n| n.to_a == current.to_a }.nil?
      locations << current

      neighbors(current).each do |neighbor|
        next if locations.include?(neighbor.to_a)
        open_set << neighbor if open_set.find_index{ |n| n.to_a == neighbor.to_a }.nil?
      end
    end
  end

  return locations
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

  def to_a
    [@x, @y]
  end
end

p search.count
