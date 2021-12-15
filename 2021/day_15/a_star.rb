# gem install pqueue
require 'pqueue'
require 'set'
require './node'

class AStar
  def initialize(map, start, goal)
    @map = map
    @start_node = Node.new(start[0], start[1], goal)
    @goal = goal
  end

  def run
    closed_set = Set[]
    open_set = PQueue.new([@start_node]) { |a, b| a.g_score < b.g_score }

    until open_set.empty?
      current = open_set.pop
      next unless closed_set.add?(current.to_a)

      return current.g_score if current.to_a == @goal

      neighbors(current).each do |neighbor|
        next if closed_set.include?(neighbor.to_a)

        open_set.push(neighbor)
      end
    end

    []
  end

  private

  def neighbors(node)
    n = []
    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |i, j|
      x = node.x + i
      y = node.y + j
      g = @map[[x, y]]
      next unless g

      n << Node.new(x, y, node.goal, node.g_score + g)
    end
    n
  end
end
