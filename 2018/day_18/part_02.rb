# --- Part Two ---
# This important natural resource will need to last for at least thousands of years. Are the Elves collecting this lumber sustainably?

# What will the total resource value of the lumber collection area be after 1000000000 minutes?

def check_open(k)
  adjacent_trees = 0
  [1, -1, 1i, -1i, 1 + 1i, 1 - 1i, -1 + 1i, -1 - 1i].each do |i|
    adjacent_trees += 1 if @map[k + i] == '|'
  end
  adjacent_trees
end

def check_tree(k)
  adjacent_lumberjards = 0
  [1, -1, 1i, -1i, 1 + 1i, 1 - 1i, -1 + 1i, -1 - 1i].each do |i|
    adjacent_lumberjards += 1 if @map[k + i] == '#'
  end
  adjacent_lumberjards
end

def check_lumberyard(k)
  adjacent_trees = 0
  adjacent_lumberjards = 0
  [1, -1, 1i, -1i, 1 + 1i, 1 - 1i, -1 + 1i, -1 - 1i].each do |i|
    adjacent_trees += 1 if @map[k + i] == '|'
    adjacent_lumberjards += 1 if @map[k + i] == '#'
  end
  adjacent_lumberjards > 0 && adjacent_trees > 0
end

def calculate_change(k, v)
  case v
  when '.'
    check_open(k) >= 3 ? '|' : '.'
  when '|'
    check_tree(k) >= 3 ? '#' : '|'
  else
    check_lumberyard(k) ? '#' : '.'
  end
end

@map = {}

File.readlines('input.txt').each_with_index do |l, x|
  l.strip.chars.each_with_index{ |c, y| @map[(x + y * 1i)] = c }
end

1_000_000_000.times do |i|
  if i % 100 == 0
    p "#{i} => #{@map.select{ |_, v| v == '|' }.size * @map.select{ |_, v| v == '#' }.size}"
  end
  @map = @map.map{ |k, v| [k, calculate_change(k, v)] }.to_h
end

p @map.select{ |_, v| v == '|' }.size * @map.select{ |_, v| v == '#' }.size

# it starts repeating after 600 every 700
# "0 => 259700"
# "100 => 100282"
# "200 => 153924"
# "300 => 218670"
# "400 => 170772"
# "500 => 210951"
# "600 => 210528"
# "700 => 223728"
# "800 => 208603"
# "900 => 218750"
# "1000 => 215404"
# "1100 => 215760"
# "1200 => 221676"
# "1300 => 210528"
# "1400 => 223728"
# "1500 => 208603"
# "1600 => 218750"
# "1700 => 215404"
# "1800 => 215760"
# "1900 => 221676"
# "2000 => 210528"
# we can just calculate the reminder and look in the table
# (1_000_000_000 - 1000) % 700
