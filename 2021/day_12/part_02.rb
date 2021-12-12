# --- Part Two ---
# After reviewing the available paths, you realize you might have time to visit a single small cave twice. Specifically, big caves can be visited any number of times, a single small cave can be visited at most twice, and the remaining small caves can be visited at most once. However, the caves named start and end can only be visited exactly once each: once you leave the start cave, you may not return to it, and once you reach the end cave, the path must end immediately.

# Now, the 36 possible paths through the first example above are:

# start,A,b,A,b,A,c,A,end
# start,A,b,A,b,A,end
# start,A,b,A,b,end
# start,A,b,A,c,A,b,A,end
# start,A,b,A,c,A,b,end
# start,A,b,A,c,A,c,A,end
# start,A,b,A,c,A,end
# start,A,b,A,end
# start,A,b,d,b,A,c,A,end
# start,A,b,d,b,A,end
# start,A,b,d,b,end
# start,A,b,end
# start,A,c,A,b,A,b,A,end
# start,A,c,A,b,A,b,end
# start,A,c,A,b,A,c,A,end
# start,A,c,A,b,A,end
# start,A,c,A,b,d,b,A,end
# start,A,c,A,b,d,b,end
# start,A,c,A,b,end
# start,A,c,A,c,A,b,A,end
# start,A,c,A,c,A,b,end
# start,A,c,A,c,A,end
# start,A,c,A,end
# start,A,end
# start,b,A,b,A,c,A,end
# start,b,A,b,A,end
# start,b,A,b,end
# start,b,A,c,A,b,A,end
# start,b,A,c,A,b,end
# start,b,A,c,A,c,A,end
# start,b,A,c,A,end
# start,b,A,end
# start,b,d,b,A,c,A,end
# start,b,d,b,A,end
# start,b,d,b,end
# start,b,end
# The slightly larger example above now has 103 paths through it, and the even larger example now has 3509 paths through it.

# Given these new rules, how many paths through this cave system are there?

class Node
  attr_reader :name, :connections, :no_of_visits, :big

  def initialize(name)
    @name = name
    @big = name.upcase == name
    @connections = []
    @no_of_visits = if @big
                      100_000_000_000
                    elsif %w[start end].include?(name)
                      1
                    else
                      2
                    end
  end

  def add_connection(node)
    @connections << node unless @connections.include?(node)
  end

  def not_visited_connections(visited)
    cons = []
    twice = visited.filter { |v| v.name != 'start' && v.name != 'end' && !v.big }.any? { |v| visited.count(v) > 1 }
    @connections.each do |con|
      filtered = visited.filter { |c| c == con }

      if con.big
        cons << con
      elsif filtered.size == 0
        cons << con
      elsif filtered.size < (con.no_of_visits - (twice ? 1 : 0))
        cons << con
        twice = true if filtered.size > 1
      end
    end
    cons
  end
end

class Path
  attr_reader :visited

  def initialize(visited = [])
    @visited = visited.clone
  end

  def add_node(node)
    @visited << node
  end

  def to_s
    @visited.map(&:name).join(' -> ')
  end
end

@nodes = []
@start_node = nil
@end_node = nil

def find_or_create_node(name)
  node = @nodes.find { |node| node.name == name }
  return node if node

  node = Node.new(name)

  @start_node = node if name == 'start'
  @end_node = node if name == 'end'

  node
end

File.readlines('input.txt').each do |line|
  a, b = line.strip.split('-')
  node_a = find_or_create_node(a)
  node_b = find_or_create_node(b)
  node_a.add_connection(node_b)
  node_b.add_connection(node_a)

  @nodes << node_a
  @nodes << node_b
end

complete_paths = []
unfinished_paths = [Path.new([@start_node])]

while unfinished_paths.any?
  current_path = unfinished_paths.pop
  current_path.visited.last.not_visited_connections(current_path.visited).each do |node|
    path = Path.new(current_path.visited)
    path.add_node(node)

    if node == @end_node
      complete_paths << path
    else
      unfinished_paths << path
    end
  end
end

p complete_paths.size
