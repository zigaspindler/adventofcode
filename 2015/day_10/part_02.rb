# --- Part Two ---

# Neat, right? You might also enjoy hearing John Conway talking about this sequence (that's Conway of Conway's Game of Life fame).

# Now, starting again with the digits in your puzzle input, apply this process 50 times. What is the length of the new result?

input = '1321131112'

50.times do
  input = input.scan(/(\d)(\1*)/).map { |m| "#{1 + m[1].length}#{m[0]}" }.join
end

puts input.length
