# --- Day 9: All in a Single Night ---

# Every year, Santa manages to deliver all of his presents in a single night.

# This year, however, he has some new locations to visit; his elves have provided him the distances between every pair of locations. He can start and end at any two (different) locations he wants, but he must visit each location exactly once. What is the shortest distance he can travel to achieve this?

# For example, given the following distances:

# London to Dublin = 464
# London to Belfast = 518
# Dublin to Belfast = 141
# The possible routes are therefore:

# Dublin -> London -> Belfast = 982
# London -> Dublin -> Belfast = 605
# London -> Belfast -> Dublin = 659
# Dublin -> Belfast -> London = 659
# Belfast -> Dublin -> London = 605
# Belfast -> London -> Dublin = 982
# The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.

# What is the distance of the shortest route?

cities = []
distances = Hash.new
shortest = 99999999

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

  shortest = distance if distance < shortest
end

puts shortest
