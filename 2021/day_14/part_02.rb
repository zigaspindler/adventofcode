# --- Part Two ---
# The resulting polymer isn't nearly strong enough to reinforce the submarine. You'll need to run more steps of the pair insertion process; a total of 40 steps should do it.

# In the above example, the most common element is B (occurring 2192039569602 times) and the least common element is H (occurring 3849876073 times); subtracting these produces 2188189693529.

# Apply 40 steps of pair insertion to the polymer template and find the most and least common elements in the result. What do you get if you take the quantity of the most common element and subtract the quantity of the least common element?

string, raw_rules = File.read('input.txt').split("\n\n")

rules = {}
raw_rules.split("\n").each { |line| k, v = line.split(' -> '); rules[k] = v }
pairs = string.chars.each_cons(2).tally
pairs.default = 0

40.times do |i|
  next_pairs = Hash.new(0)

  pairs.each do |(a, b), tally|
    i = rules[a + b]

    next_pairs[[a, i]] += tally
    next_pairs[[i, b]] += tally
  end
  pairs = next_pairs
end

totals = Hash.new(0)
pairs.each { |(a, _b), tally| totals[a] += tally }
totals[string.chars.last] += 1

min, max = totals.values.minmax
puts max - min
