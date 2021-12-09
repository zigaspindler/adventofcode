# --- Part Two ---
# Next, you need to find the largest basins so you know what areas are most important to avoid.

# A basin is all locations that eventually flow downward to a single low point. Therefore, every low point has a basin, although some basins are very small. Locations of height 9 do not count as being in any basin, and all other locations will always be part of exactly one basin.

# The size of a basin is the number of locations within the basin, including the low point. The example above has four basins.

# The top-left basin, size 3:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# The top-right basin, size 9:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# The middle basin, size 14:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# The bottom-right basin, size 9:

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678
# Find the three largest basins and multiply their sizes together. In the above example, this is 9 * 14 * 9 = 1134.

# What do you get if you multiply together the sizes of the three largest basins?

@map = {}

def get_points_around(point)
  x, y = point.split(':').map(&:to_i)
  v = @map[point]
  points = []

  points << "#{x - 1}:#{y}" if @map["#{x - 1}:#{y}"] && @map["#{x - 1}:#{y}"] > v && @map["#{x - 1}:#{y}"] != 9
  points << "#{x + 1}:#{y}" if @map["#{x + 1}:#{y}"] && @map["#{x + 1}:#{y}"] > v && @map["#{x + 1}:#{y}"] != 9
  points << "#{x}:#{y - 1}" if @map["#{x}:#{y - 1}"] && @map["#{x}:#{y - 1}"] > v && @map["#{x}:#{y - 1}"] != 9
  points << "#{x}:#{y + 1}" if @map["#{x}:#{y + 1}"] && @map["#{x}:#{y + 1}"] > v && @map["#{x}:#{y + 1}"] != 9

  points
end

def get_basin(point)
  points_to_check = get_points_around(point)
  basin = [point]

  while points_to_check.any?
    next_point = points_to_check.pop
    points_to_check += get_points_around(next_point)
    basin << next_point
  end

  basin.uniq
end

File.readlines('input.txt').each_with_index do |line, i|
  line.strip.split('').each_with_index do |c, j|
    @map["#{i}:#{j}"] = c.to_i
  end
  size = i
end

basins = []

@map.each do |k, v|
  x, y = k.split(':').map(&:to_i)

  next unless (@map["#{x - 1}:#{y}"].nil? || @map["#{x - 1}:#{y}"] > v) &&
              (@map["#{x + 1}:#{y}"].nil? || @map["#{x + 1}:#{y}"] > v) &&
              (@map["#{x}:#{y - 1}"].nil? || @map["#{x}:#{y - 1}"] > v) &&
              (@map["#{x}:#{y + 1}"].nil? || @map["#{x}:#{y + 1}"] > v)

  basins << get_basin(k)
end

p basins.map(&:size).sort.last(3).inject(:*)
