# --- Part Two ---
# You discover a dial on the side of the device; it seems to let you select a square of any size, not just 3x3. Sizes from 1x1 to 300x300 are supported.

# Realizing this, you now must find the square of any size with the largest total power. Identify this square by including its size as a third parameter after the top-left coordinate: a 9x9 square with a top-left corner of 3,5 is identified as 3,5,9.

# For example:

# For grid serial number 18, the largest total square (with a total power of 113) is 16x16 and has a top-left corner of 90,269, so its identifier is 90,269,16.
# For grid serial number 42, the largest total square (with a total power of 119) is 12x12 and has a top-left corner of 232,251, so its identifier is 232,251,12.
# What is the X,Y,size identifier of the square with the largest total power?

@input = 9810
@hash_grid = {}
@sums_grid = {}

def caluclate_fuel_level(x, y)
  rack_id = x + 10
  power = rack_id * y
  power += @input
  power *= rack_id
  (power.digits[2] || 0) - 5
end

def caluclate_sums_grid(x, y)
  tl = @sums_grid[[x - 1, y - 1]] || 0
  l = @sums_grid[[x - 1, y]] || 0
  t = @sums_grid[[x, y - 1]] || 0

  @hash_grid[[x ,y]] + l + t - tl
end

def calculate_total_power(x, y, size)
  tl = @sums_grid[[x - 1, y - 1]] || 0
  tr = @sums_grid[[x + size - 1, y - 1]] || 0
  bl = @sums_grid[[x - 1, y + size - 1]] || 0
  br = @sums_grid[[x + size - 1, y +  size - 1]] || 0

  br + tl - tr - bl
end

def calculate_max_power(x, y)
  max_power = 0
  size = 0
  (300 - [x, y].max).times do |i|
    power = calculate_total_power(x, y, i)
    next if power < max_power

    max_power = power
    size = i
  end

  [max_power, size]
end

for x in 1..300
  for y in 1..300
    @hash_grid[[x, y]] = caluclate_fuel_level(x, y)
    @sums_grid[[x, y]] = caluclate_sums_grid(x, y)
  end
end

hash_fuel_levels = {}

@hash_grid.each do |k, _v|
  hash_fuel_levels[k] =  calculate_max_power(* k)
end

result = hash_fuel_levels.max_by{ |_, v| v[0] }

p "#{result[0][0]},#{result[0][1]},#{result[1][1]}"
