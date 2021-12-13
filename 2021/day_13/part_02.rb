# --- Part Two ---
# Finish folding the transparent paper according to the instructions. The manual says the code is always eight capital letters.

# What code do you use to activate the infrared thermal imaging camera system?

d, f = File.read('input.txt').split("\n\n")

@dots = {}
folds = f.split("\n").map { |fold| fold.split(' ').last }

def fold_x(value)
  keys_to_add = []
  @dots.each_key do |k|
    x, y = k.split(':').map(&:to_i)
    next if x <= value

    new_x = x - (x - value) * 2

    @dots[k] = false
    keys_to_add << "#{new_x}:#{y}"
  end

  keys_to_add.each { |k| @dots[k] = true }
end

def fold_y(value)
  keys_to_add = []
  @dots.each_key do |k|
    x, y = k.split(':').map(&:to_i)
    next if y <= value

    new_y = y - (y - value) * 2

    @dots[k] = false
    keys_to_add << "#{x}:#{new_y}"
  end

  keys_to_add.each { |k| @dots[k] = true }
end

def fold_dots(fold)
  axis, value = fold.split('=')

  if axis == 'x'
    fold_x(value.to_i)
  else
    fold_y(value.to_i)
  end

  @dots.delete_if { |_k, v| !v }
end

d.split("\n").each do |dot|
  x, y = dot.split(',')
  @dots["#{x}:#{y}"] = true
end

folds.each { |fold| fold_dots(fold) }

max_x = @dots.max_by { |k, _v| k.split(':').first.to_i }.first.split(':').first.to_i
max_y = @dots.max_by { |k, _v| k.split(':').last.to_i }.first.split(':').last.to_i

(0..max_y).each do |y|
  (0..max_x).each do |x|
    if @dots["#{x}:#{y}"]
      print '#'
    else
      print ' '
    end
  end
  print "\n"
end
