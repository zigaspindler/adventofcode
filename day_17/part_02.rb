# --- Part Two ---

# While playing with all the containers in the kitchen, another load of eggnog arrives! The shipping and receiving department is requesting as many containers as you can spare.

# Find the minimum number of containers that can exactly fit all 150 liters of eggnog. How many different ways can you fill that number of containers and still hold exactly 150 litres?

# In the example above, the minimum number of containers was two. There were three ways to use that many containers, and so the answer there would be 3.

# Although it hasn't changed, you can still get your puzzle input.

CAPACITY = 150

containers = []
solutions = []

File.open('input.txt', 'r').each_line { |line| containers << line.chomp.to_i }

(1...containers.length).each do |i|
  containers.combination(i).to_a.each do |comb|
    solutions << comb.length if comb.inject(:+) == CAPACITY
  end
end

puts solutions.group_by { |i| i }.sort.first[1].length
