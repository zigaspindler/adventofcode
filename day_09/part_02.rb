# --- Part Two ---

# The next year, just to show off, Santa decides to take the route with the longest distance instead.

# He can still start and end at any two (different) locations he wants, and he still must visit each location exactly once.

# For example, given the distances above, the longest route would be 982 via (for example) Dublin -> London -> Belfast.

# What is the distance of the longest route?

cities = []
distances = Hash.new
longest = 0

File.open('input.txt', 'r').each_line do |line|
  line.chomp.match /(.*) to (.*) = (\d+)/
  cities << $1 unless cities.include? $1
  cities << $2 unless cities.include? $2
  distances[[$1, $2]], distances[[$2, $1]] = $3.to_i, $3.to_i
end

cities.permutation.each do |path|
  distance = 0
  
  for i in 0...path.length - 1
    distance += distances[[path[i], path[i + 1]]]
  end

  longest = distance if distance > longest
end

puts longest
