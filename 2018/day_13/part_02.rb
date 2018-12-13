# --- Part Two ---
# There isn't much you can do to prevent crashes in this ridiculous system. However, by predicting the crashes, the Elves know where to be in advance and instantly remove the two crashing carts the moment any crash occurs.

# They can proceed like this for a while, but eventually, they're going to run out of carts. It could be useful to figure out where the last cart that hasn't crashed will end up.

# For example:

# />-<\  
# |   |  
# | /<+-\
# | | | v
# \>+</ |
#   |   ^
#   \<->/

# /---\  
# |   |  
# | v-+-\
# | | | |
# \-+-/ |
#   |   |
#   ^---^

# /---\  
# |   |  
# | /-+-\
# | v | |
# \-+-/ |
#   ^   ^
#   \---/

# /---\  
# |   |  
# | /-+-\
# | | | |
# \-+-/ ^
#   |   |
#   \---/
# After four very expensive crashes, a tick ends with only one cart remaining; its final location is 6,4.

# What is the location of the last cart at the end of the first tick where it is the only cart left?

@directions = {
  '>' => 1,
  '<' => -1,
  '^' => -1i,
  'v' => 1i
}

class Cart
  attr_accessor :position, :direction, :cross, :crashed

  def initialize(pos, dir)
    @position = pos
    @direction = dir
    @cross = 0
    @crashed = false
  end

  def move
    @position += @direction
  end

  def turn(track)
    case track
    when '\\'
      @direction *= @direction.real == 0 ? -1i : 1i
    when '/'
      @direction *= @direction.real == 0 ? 1i : -1i
    when '+'
      @direction *= -1i * 1i ** @cross
      @cross = (@cross + 1) % 3
    end
  end
end

tracks = {}
carts = []

File.readlines('input.txt').each_with_index do |line, y|
  line.chars.each_with_index do |c, x|
    case c
    when '\n'
      next
    when * %w[ > < ^ v ]
      carts << Cart.new(x + y * 1i, @directions[c])
    when * %w[ \\ / + ]
      tracks[x + y * 1i] = c
    end
  end
end

while carts.size > 1 do
  carts.sort_by!{ |c| [c.position.imaginary, c.position.real] }
  carts.each do |c|
    next if c.crashed
    c.move
    crashed = carts.select{ |c2| c2.position == c.position && c2 != c }
    if crashed.any?
      c.crashed = true
      crashed.each{ |c2| c2.crashed = true }
    end
    c.turn(tracks[c.position])
  end
  carts = carts.select{ |c| !c.crashed }
end

p "#{carts.first.position.real},#{carts.first.position.imaginary}"
