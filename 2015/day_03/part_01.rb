# --- Day 3: Perfectly Spherical Houses in a Vacuum ---

# Santa is delivering presents to an infinite two-dimensional grid of houses.

# He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

# However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

# For example:

# > delivers presents to 2 houses: one at the starting location, and one to the east.
# ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
# ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.

map = Hash.new
location = [0, 0]
map[0] = {0 => 1}
visited_houses = 1

File.open('input.txt', 'r') do |input|
  input.gets.chomp.each_char do |char|
    if char == '>'
      location[0] += 1
    elsif char == '<'
      location[0] -= 1
    elsif char == '^'
      location[1] += 1
    else
      location[1] -= 1
    end

    if map[location[0]].nil?
      map[location[0]] = { location[1] => 1 }
      visited_houses += 1
    elsif map[location[0]][location[1]].nil?
      map[location[0]][location[1]] = 1
      visited_houses += 1
    end
  end
end

puts visited_houses
