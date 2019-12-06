# --- Part Two ---
# Now, you just need to figure out how many orbital transfers you (YOU) need to take to get to Santa (SAN).

# You start at the object YOU are orbiting; your destination is the object SAN is orbiting. An orbital transfer lets you move from any object to an object orbiting or orbited by that object.

# For example, suppose you have the following map:

# COM)B
# B)C
# C)D
# D)E
# E)F
# B)G
# G)H
# D)I
# E)J
# J)K
# K)L
# K)YOU
# I)SAN
# Visually, the above map of orbits looks like this:

#                           YOU
#                          /
#         G - H       J - K - L
#        /           /
# COM - B - C - D - E - F
#                \
#                 I - SAN
# In this example, YOU are in orbit around K, and SAN is in orbit around I. To move from K to I, a minimum of 4 orbital transfers are required:

# K to J
# J to E
# E to D
# D to I
# Afterward, the map of orbits looks like this:

#         G - H       J - K - L
#        /           /
# COM - B - C - D - E - F
#                \
#                 I - SAN
#                  \
#                   YOU
# What is the minimum number of orbital transfers required to move from the object YOU are orbiting to the object SAN is orbiting? (Between the objects they are orbiting - not between YOU and SAN.)

class SpaceObject
  attr_accessor :name, :father, :children, :count, :path

  def initialize(name)
    @name = name
    @children = []
    @count = 0
    @path = []
  end

  def add_child(child)
    @children << child
    child.father = self
    update_count
  end

  def update_count
    @count = @children.inject(0) { |acc, c|  acc + c.count } + @children.size
    @father.update_count if @father
  end

  def steps
    @path.length
  end

  def <=>(other)
    steps <=> other.steps
  end

  def to_s
    "#{@name}: #{@count}"
  end
end

class Node
  attr_accessor :steps, :possible_nodes, :visited
  def initializer
    @steps = 0
    @possible_nodes = []
    @visited = []
  end
end

objects = {}

File.readlines('input.txt').map do |orbit|
  f, c = orbit.strip.split(')')
  father = objects[f] ||= SpaceObject.new(f)
  child = objects[c] ||= SpaceObject.new(c)

  father.add_child(child)
end

def reconstruct_path(came_from, current)
  total_path = [current]
  while came_from.keys.include?(current.name) do
    current = came_from[current.name]
    total_path << current
  end

  total_path
end

nodes = [objects['YOU']]
g_score = { 'YOU' => 0 }
came_from = {}

while nodes.any? do
  current = nodes.sort!.delete_at(0)
  
  if current.name == 'SAN'
    p reconstruct_path(came_from, current).length - 3
    return
  end

  (current.children + [current.father]).filter{ |n| n }.each do |n|
    tentative = g_score[current.name] + 1
    n_score = g_score[n.name] || Float::INFINITY
    if tentative < n_score
      came_from[n.name] = current
      g_score[n.name] = tentative
      nodes << n unless nodes.include?(n)
    end
  end
end
