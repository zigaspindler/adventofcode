def neighbors(node)
  n = []
  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |a|
    neighbor = Node.new(node.x + a[0], node.y + a[1], node.goal, node.g_score + 1)
    n << neighbor if open?(neighbor)
  end
  n
end

def open?(node)
  x, y = node.to_a
  @map[x][y] != '#'
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
  def initialize(x, y, goal, g = 0)
    @x = x
    @y = y
    @goal = goal
    @g = g
  end

  def x
    @x
  end

  def y
    @y
  end

  def goal
    @goal
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
    @f_score ||= @g + (@x - @goal[0]).abs + (@y - @goal[1]).abs
  end
end
