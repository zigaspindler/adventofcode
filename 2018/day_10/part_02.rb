# --- Part Two ---
# Good thing you didn't have to wait, because that would have taken a long time - much longer than the 3 seconds in the example above.

# Impressed by your sub-hour communication capabilities, the Elves are curious: exactly how many seconds would they have needed to wait for that message to appear?

original_points = File.readlines('input.txt').map do |l|
  _, x, y, vx, vy = * /.+<((?:-| )?\d+), ((?:-| )?\d+)>.+<((?:-| )?\d+), ((?:-| )?\d+)>/.match(l)
  [x.to_i, y.to_i, vx.to_i, vy.to_i]
end

points = original_points.to_ary

min_size = 100_000_000_000
min_counter = nil

15_000.times do |i|
  points = points.map{ |p| [p[0] + p[2], p[1] + p[3], p[2], p[3]] }
  min_x, max_x = points.minmax_by{ |p| p[0] }.map{ |p| p[0] }
  min_y, max_y = points.minmax_by{ |p| p[1] }.map{ |p| p[1] }

  current_size = (max_x - min_x) * (max_y - min_y)
  if current_size < min_size
    min_size = current_size
    min_counter = i + 1
  end
end

p min_counter
