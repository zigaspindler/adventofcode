# --- Part Two ---
# It seems like the individual flashes aren't bright enough to navigate. However, you might have a better option: the flashes seem to be synchronizing!

# In the example above, the first time all octopuses flash simultaneously is step 195:

# After step 193:
# 5877777777
# 8877777777
# 7777777777
# 7777777777
# 7777777777
# 7777777777
# 7777777777
# 7777777777
# 7777777777
# 7777777777

# After step 194:
# 6988888888
# 9988888888
# 8888888888
# 8888888888
# 8888888888
# 8888888888
# 8888888888
# 8888888888
# 8888888888
# 8888888888

# After step 195:
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# 0000000000
# If you can calculate the exact moments when the octopuses will all flash simultaneously, you should be able to navigate through the cavern. What is the first step during which all octopuses flash?

require './octopus'

@octopuses = {}

def increase_neighbours(x, y)
  for i in -1..1 do
    for j in -1..1 do
      next if i == 0 && j == 0
      next if x + i < 0 || x + i > 9
      next if y + j < 0 || y + j > 9

      @octopuses["#{x + i}:#{y + j}"].increase_power
    end
  end
end


File.readlines('input.txt').each_with_index do |line, i|
  line.strip.split('').each_with_index do |c, j|
    @octopuses["#{i}:#{j}"] = Octopus.new(c.to_i)
  end
end

step = 0

loop do
  step += 1
  @octopuses.each_value(&:increase_power)

  flashed = true
  while flashed do
    flashed = false
    @octopuses.each do |k, o|
      next unless o.flash!

      flashed = true
      increase_neighbours(*k.split(':').map(&:to_i))
      break
    end
  end

  break if @octopuses.each_value.all?(&:flashed?)

  @octopuses.each_value(&:reset)
end

p step