# --- Part Two ---
# Time to improve the polymer.

# One of the unit types is causing problems; it's preventing the polymer from collapsing as much as it should. Your goal is to figure out which unit type is causing the most problems, remove all instances of it (regardless of polarity), fully react the remaining polymer, and measure its length.

# For example, again using the polymer dabAcCaCBAcCcaDA from above:

# Removing all A/a units produces dbcCCBcCcD. Fully reacting this polymer produces dbCBcD, which has length 6.
# Removing all B/b units produces daAcCaCAcCcaDA. Fully reacting this polymer produces daCAcaDA, which has length 8.
# Removing all C/c units produces dabAaBAaDA. Fully reacting this polymer produces daDA, which has length 4.
# Removing all D/d units produces abAcCaCBAcCcaA. Fully reacting this polymer produces abCBAc, which has length 6.
# In this example, removing all C/c units was best, producing the answer 4.

# What is the length of the shortest polymer you can produce by removing all units of exactly one type and fully reacting the result?

original_input = File.read('input.txt').strip.chars

results = {}

for c in 'a'..'z'
  input = original_input.dup
  input.delete(c)
  input.delete(c.upcase)
  changed = true

  while(changed) do
    changed = false
  
    start = 0
  
    input.each_with_index do |c, i|
      next if c != input[i + 1]&.swapcase
  
      changed = true
      input.delete_at(i)
      input.delete_at(i)
    end
  end
  results[c] = input.length
end

p results.sort_by{ |k, v| v }.first[1]
