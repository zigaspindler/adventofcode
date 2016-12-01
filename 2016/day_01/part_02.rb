# --- Part Two ---

# Then, you notice the instructions continue on the back of the Recruiting Document. Easter Bunny HQ is actually at the first location you visit twice.

# For example, if your instructions are R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due East.

# How many blocks away is the first location you visit twice?

@orientation = :north
@position = [0, 0]
@positions = [@position.clone]

def can_add_path?(path)
  for i in 0...path
    case @orientation
    when :north
      @position[0] += 1
    when :south
      @position[0] -= 1
    when :east
      @position[1] += 1
    when :west
      @position[1] -= 1
    end

    return false if @positions.include? @position

    @positions << @position.clone
  end
  true
end

File.open('input.txt', 'r').read.split(', ').each do |ins|
  turn = ins.slice! 0

  case @orientation
  when :north
    @orientation = turn == 'L' ? :west : :east
  when :south
    @orientation = turn == 'L' ? :east : :west
  when :east
    @orientation = turn == 'L' ? :north : :south
  when :west
    @orientation = turn == 'L' ? :south : :north
  end

  break unless can_add_path? ins.to_i
end

puts @position[0].abs + @position[1].abs
