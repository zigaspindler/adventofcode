# --- Part Two ---

# Your cookie recipe becomes wildly popular! Someone asks if you can make another recipe that has exactly 500 calories per cookie (so they can use it as a meal replacement). Keep the rest of your award-winning process the same (100 teaspoons, same ingredients, same scoring system).

# For example, given the ingredients above, if you had instead selected 40 teaspoons of butterscotch and 60 teaspoons of cinnamon (which still adds to 100), the total calorie count would be 40*8 + 60*3 = 500. The total score would go down, though: only 57600000, the best you can do in such trying circumstances.

# Given the ingredients in your kitchen and their properties, what is the total score of the highest-scoring cookie you can make with a calorie total of 500?

class Ingredient
  attr_accessor :name, :capacity, :durability, :flavor, :texture, :calories

  def initialize(string)
    string.match /(\w+): \w+ (-?\d+), \w+ (-?\d+), \w+ (-?\d+), \w+ (-?\d+), \w+ (-?\d+)/
    @name, @capacity, @durability, @flavor, @texture, @calories = $1, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i
  end
end

ingredients = []

File.open('input.txt', 'r').each_line do |line|
  ingredients.push Ingredient.new line.chomp
end

best = 0

(0...100).each do |i|
  (0...100 - i).each do |j|
    (0...100 - i - j).each do |k|
      counters = [i, j, k, (100 - i - j - k)]
      values = Hash.new
      %w(capacity durability flavor texture calories).each do |component|
        values[component] = ingredients.each_with_index.map { |ing, i| ing.send("#{component}") * counters[i] }.inject(:+)
      end
      next unless values.values.min > 0 and values['calories'] == 500
      score = values.reject { |k, v| k == 'calories' }.values.inject(:*)
      best = score if score > best
    end
  end
end

puts best
