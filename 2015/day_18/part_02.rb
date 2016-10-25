# --- Part Two ---

# You flip the instructions over; Santa goes on to point out that this is all just an implementation of Conway's Game of Life. At least, it was, until you notice that something's wrong with the grid of lights you bought: four lights, one in each corner, are stuck on and can't be turned off. The example above will actually run like this:

# Initial state:
# ##.#.#
# ...##.
# #....#
# ..#...
# #.#..#
# ####.#

# After 1 step:
# #.##.#
# ####.#
# ...##.
# ......
# #...#.
# #.####

# After 2 steps:
# #..#.#
# #....#
# .#.##.
# ...##.
# .#..##
# ##.###

# After 3 steps:
# #...##
# ####.#
# ..##.#
# ......
# ##....
# ####.#

# After 4 steps:
# #.####
# #....#
# ...#..
# .##...
# #.....
# #.#..#

# After 5 steps:
# ##.###
# .##..#
# .##...
# .##...
# #.#...
# ##...#
# After 5 steps, this example now has 17 lights on.

# In your grid of 100x100 lights, given your initial configuration, but with the four corners always in the on state, how many lights are on after 100 steps?

SIZE = 100

@lights = Array.new(SIZE) { Array.new(SIZE) }

def number_of_living_neighbors(x, y)
  living = 0
  (-1..1).each do |i|
    (-1..1).each do |j|
      xi, yj = x + i, y + j
      next if xi < 0 || yj < 0 || xi >= SIZE || yj >= SIZE || (xi == x && yj == y)
      living += @lights[xi][yj]
    end
  end
  living
end

def status(x, y)
  return 1 if (x == 0 and y == 0) || (x == 0 and y == SIZE - 1) || (x == SIZE - 1 and y == 0) || (x == SIZE - 1 and y == SIZE - 1)

  living = number_of_living_neighbors(x, y)
  if @lights[x][y] == 1
    living == 3 || living == 2 ? 1 : 0
  else
    living == 3 ? 1 : 0
  end
end

File.open('input.txt', 'r').each_line.with_index do |line, i|
  @lights[i] = line.chomp.split('').map { |c| c == '#' ? 1 : 0 }
end

100.times do
  temp_lights = Array.new
  (0...SIZE).each do |x|
    line = []
    (0...SIZE).each do |y|
      line << status(x, y)
    end
    temp_lights << line
  end
  @lights = temp_lights
end

puts @lights.flatten.inject(:+)
