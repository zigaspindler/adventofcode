# --- Part Two ---

# You finally arrive at the bathroom (it's a several minute walk from the lobby so visitors can behold the many fancy conference rooms and water coolers on this floor) and go to punch in the code. Much to your bladder's dismay, the keypad is not at all like you imagined it. Instead, you are confronted with the result of hundreds of man-hours of bathroom-keypad-design meetings:

#     1
#   2 3 4
# 5 6 7 8 9
#   A B C
#     D
# You still start at "5" and stop when you're at an edge, but given the same instructions as above, the outcome is very different:

# You start at "5" and don't move at all (up and left are both edges), ending at 5.
# Continuing from "5", you move right twice and down three times (through "6", "7", "B", "D", "D"), ending at D.
# Then, from "D", you move five more times (through "D", "B", "C", "C", "B"), ending at B.
# Finally, after five more moves, you end at 3.
# So, given the actual keypad layout, the code would be 5DB3.

# Using the same instructions in your puzzle input, what is the correct bathroom code?

codes = %w( 1 2 3 4 5 6 7 8 9 A B C D )

code = 4

result = ''

File.readlines('input.txt').each do |line|
  line.split('').each do |ins|
    case ins
    when 'L'
      code -= 1 unless [0, 1, 4, 9, 12].include? code
    when 'R'
      code += 1 unless [0, 3, 8, 11, 12].include? code
    when 'U'
      if code == 2
        code = 0
      elsif [5, 6, 7, 9, 10, 11].include? code
        code -= 4
      elsif code == 12
        code = 10
      end
    when 'D'
      if code == 0
        code = 2
      elsif [1, 2, 3, 5 ,6, 7].include? code
        code += 4
      elsif code == 10
        code = 12
      end
    end
  end
  result << codes[code]
end

puts result
