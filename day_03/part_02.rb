# --- Part Two ---

# The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.

# Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.

# This year, how many houses receive at least one present?

# For example:

# ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
# ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
# ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.

map = Hash.new
locations = [[0, 0], [0, 0]]
map[0] = {0 => 1}
visited_houses = 1

File.open('input.txt', 'r') do |input|
  input.gets.chomp.each_char.with_index do |char, index|
    santa = index % 2
    if char == '>'
      locations[santa][0] += 1
    elsif char == '<'
      locations[santa][0] -= 1
    elsif char == '^'
      locations[santa][1] += 1
    else
      locations[santa][1] -= 1
    end

    location = locations[santa]

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
