# --- Part Two ---
# Once you give them the coordinates, the Elves quickly deploy an Instant Monitoring Station to the location and discover the worst: there are simply too many asteroids.

# The only solution is complete vaporization by giant laser.

# Fortunately, in addition to an asteroid scanner, the new monitoring station also comes equipped with a giant rotating laser perfect for vaporizing asteroids. The laser starts by pointing up and always rotates clockwise, vaporizing any asteroid it hits.

# If multiple asteroids are exactly in line with the station, the laser only has enough power to vaporize one of them before continuing its rotation. In other words, the same asteroids that can be detected can be vaporized, but if vaporizing one asteroid makes another one detectable, the newly-detected asteroid won't be vaporized until the laser has returned to the same position by rotating a full 360 degrees.

# For example, consider the following map, where the asteroid with the new monitoring station (and laser) is marked X:

# .#....#####...#..
# ##...##.#####..##
# ##...#...#.#####.
# ..#.....X...###..
# ..#.#.....#....##
# The first nine asteroids to get vaporized, in order, would be:

# .#....###24...#..
# ##...##.13#67..9#
# ##...#...5.8####.
# ..#.....X...###..
# ..#.#.....#....##
# Note that some asteroids (the ones behind the asteroids marked 1, 5, and 7) won't have a chance to be vaporized until the next full rotation. The laser continues rotating; the next nine to be vaporized are:

# .#....###.....#..
# ##...##...#.....#
# ##...#......1234.
# ..#.....X...5##..
# ..#.9.....8....76
# The next nine to be vaporized are then:

# .8....###.....#..
# 56...9#...#.....#
# 34...7...........
# ..2.....X....##..
# ..1..............
# Finally, the laser completes its first full rotation (1 through 3), a second rotation (4 through 8), and vaporizes the last asteroid (9) partway through its third rotation:

# ......234.....6..
# ......1...5.....7
# .................
# ........X....89..
# .................
# In the large example above (the one with the best monitoring station location at 11,13):

# The 1st asteroid to be vaporized is at 11,12.
# The 2nd asteroid to be vaporized is at 12,1.
# The 3rd asteroid to be vaporized is at 12,2.
# The 10th asteroid to be vaporized is at 12,8.
# The 20th asteroid to be vaporized is at 16,0.
# The 50th asteroid to be vaporized is at 16,9.
# The 100th asteroid to be vaporized is at 10,16.
# The 199th asteroid to be vaporized is at 9,6.
# The 200th asteroid to be vaporized is at 8,2.
# The 201st asteroid to be vaporized is at 10,9.
# The 299th and final asteroid to be vaporized is at 11,1.
# The Elves are placing bets on which will be the 200th asteroid to be vaporized. Win the bet by determining which asteroid that will be; what do you get if you multiply its X coordinate by 100 and then add its Y coordinate? (For example, 8,2 becomes 802.)

asteroids = []

class Target
  attr_accessor :rad, :distance, :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @distance = Math.sqrt(x * x + y * y)
    @rad = calculate_rad
  end

  def calculate_rad
    rad = if @y == 0 && @x > 0
        0
      elsif @y == 0 && @x < 0
        Math::PI
      elsif @x < 0
        Math.atan(@y.to_f / @x.to_f) + Math::PI
      else
        Math.atan(@y.to_f / @x.to_f)
      end

    rad -= Math::PI / 2.0
    rad += 2 * Math::PI if rad < 0

    rad = 2 * Math::PI if rad == 0


    @rad = -rad
  end
end

File.readlines('input.txt').map.with_index do |line, j|
  line.strip.split('').each_with_index do |c, i|
    asteroids << [i, j] if c == '#'
  end
end

position = [22, 19]

asteroids.delete(position)

not_sorted = asteroids.map { |a| Target.new(a[0] - position[0], position[1] - a[1]) }.sort { |a, b| a.rad <=> b.rad }

sorted = []

while not_sorted.any?
  
  current = not_sorted.shift

  if sorted.last && current.rad == sorted.last.rad
    if current.distance > sorted.last.distance
      not_sorted << current
    else
      previous = sorted.pop
      not_sorted << previous
      sorted << current
    end
  else
    sorted << current
  end
  
  break if sorted.length == 200
end

target =  sorted.last

p (target.x + position[0]) * 100 + position[1] - target.y
