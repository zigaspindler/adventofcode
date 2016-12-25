# --- Part Two ---

# Of course, if you leave the cleaning robot somewhere weird, someone is bound to notice.

# What is the fewest number of steps required to start at 0, visit every non-0 number marked on the map at least once, and then return to 0?

require_relative 'a_star'

positions = []
distances = []

@map = File.readlines('input.txt').each_with_index.map do |line, i|
  line.chars.each_with_index do |c, j|
    if c.to_i.to_s == c
      positions[c.to_i] = [i, j]
    end
  end
  line.strip
end

(0...positions.length).to_a.combination(2).to_a.each do |c|
  distances[c[0]] = [] unless distances[c[0]]
  distances[c[1]] = [] unless distances[c[1]]

  p1 = positions[c[0]]
  p2 = positions[c[1]]
  distances[c[0]][c[1]] = distances[c[1]][c[0]] = a_star(Node.new(p1[0], p1[1], p2), p2).length - 1
end

shortest = -1

(1...positions.length).to_a.permutation.to_a.each do |perm|
  perm.unshift(0)
  perm << 0
  length = 0
  for i in 0...perm.length - 1
    length += distances[perm[i]][perm[i + 1]]
  end
  shortest = length if length < shortest || shortest == -1
end

p shortest
