# --- Part Two ---
# Suppose the lanternfish live forever and have unlimited food and space. Would they take over the entire ocean?

# After 256 days in the example above, there would be a total of 26984457539 lanternfish!

# How many lanternfish would there be after 256 days?

initial_state = File.read('input.txt').strip.split(',')

state = Array.new(9, 0)

initial_state.each_with_object(Hash.new(0)) { |s, result| result[s] += 1 }.each { |k, v| state[k.to_i] = v }

256.times do
  current = state.shift
  state[6] += current
  state[8] = current
end

p state.inject(:+)
