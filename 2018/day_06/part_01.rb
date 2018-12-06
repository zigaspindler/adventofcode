# --- Day 6: Chronal Coordinates ---
# The device on your wrist beeps several times, and once again you feel like you're falling.

# "Situation critical," the device announces. "Destination indeterminate. Chronal interference detected. Please specify new target coordinates."

# The device then produces a list of coordinates (your puzzle input). Are they places it thinks are safe or dangerous? It recommends you check manual page 729. The Elves did not give you a manual.

# If they're dangerous, maybe you can minimize the danger by finding the coordinate that gives the largest distance from the other points.

# Using only the Manhattan distance, determine the area around each coordinate by counting the number of integer X,Y locations that are closest to that coordinate (and aren't tied in distance to any other coordinate).

# Your goal is to find the size of the largest area that isn't infinite. For example, consider the following list of coordinates:

# 1, 1
# 1, 6
# 8, 3
# 3, 4
# 5, 5
# 8, 9
# If we name these coordinates A through F, we can draw them on a grid, putting 0,0 at the top left:

# ..........
# .A........
# ..........
# ........C.
# ...D......
# .....E....
# .B........
# ..........
# ..........
# ........F.
# This view is partial - the actual grid extends infinitely in all directions. Using the Manhattan distance, each location's closest coordinate can be determined, shown here in lowercase:

# aaaaa.cccc
# aAaaa.cccc
# aaaddecccc
# aadddeccCc
# ..dDdeeccc
# bb.deEeecc
# bBb.eeee..
# bbb.eeefff
# bbb.eeffff
# bbb.ffffFf
# Locations shown as . are equally far from two or more coordinates, and so they don't count as being closest to any.

# In this example, the areas of coordinates A, B, C, and F are infinite - while not shown here, their areas extend forever outside the visible grid. However, the areas of coordinates D and E are finite: D is closest to 9 locations, and E is closest to 17 (both including the coordinate's location itself). Therefore, in this example, the size of the largest area is 17.

# What is the size of the largest area that isn't infinite?

def closest_coord(point)
  closest = nil
  closest_distance = 10000000
  @coords.each_with_index do |c, i|
    dist = distance(c, point)

    if dist == closest_distance
      closest = -1
    elsif dist < closest_distance
      closest = i
      closest_distance = dist
    end
  end

  closest
end

def distance(p1, p2)
  (p1[0] - p2[0]).abs + (p1[1] - p2[1]).abs
end

@coords = File.readlines('input.txt').map{ |l| l.split(', ').map(&:to_i) }
possible_coords = {}
@coords.each_with_index do |_, i|
  possible_coords[i] = 0
end

# we can assume everything outside is infinite
min_x, _, max_x, _ = @coords.minmax_by{ |c| c[0] }.flatten
_, min_y, _, max_y = @coords.minmax_by{ |c| c[1] }.flatten

for i in (min_x..max_x)
  for j in (min_y..max_y)
    closest = closest_coord([i, j])
    next if closest == -1

    if i == min_x || i == max_x || j == min_y || j == max_y
      possible_coords.delete(closest)
    else
      possible_coords[closest] += 1 if possible_coords[closest]
    end
  end
end

p possible_coords.max_by{ |k, v| v }[1]
