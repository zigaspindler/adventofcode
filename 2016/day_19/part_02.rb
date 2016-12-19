# --- Part Two ---

# Realizing the folly of their present-exchange rules, the Elves agree to instead steal presents from the Elf directly across the circle. If two Elves are across the circle, the one on the left (from the perspective of the stealer) is stolen from. The other rules remain unchanged: Elves with no presents are removed from the circle entirely, and the other elves move in slightly to keep the circle evenly spaced.

# For example, with five Elves (again numbered 1 to 5):

# The Elves sit in a circle; Elf 1 goes first:
#   1
# 5   2
#  4 3
# Elves 3 and 4 are across the circle; Elf 3's present is stolen, being the one to the left. Elf 3 leaves the circle, and the rest of the Elves move in:
#   1           1
# 5   2  -->  5   2
#  4 -          4
# Elf 2 steals from the Elf directly across the circle, Elf 5:
#   1         1 
# -   2  -->     2
#   4         4 
# Next is Elf 4 who, choosing between Elves 1 and 2, steals from Elf 1:
#  -          2  
#     2  -->
#  4          4
# Finally, Elf 2 steals from Elf 4:
#  2
#     -->  2  
#  -
# So, with five Elves, the Elf that sits starting in position 2 gets all the presents.

# With the number of Elves given in your puzzle input, which Elf now gets all the presents?

INPUT = 3018458

class Elf
  attr_accessor :no, :left, :right

  def initialize(right = nil)
    if right
      @no = right.no + 1
      @right = right
    else
      @no = 1
    end
  end

  def remove
    @left.right = @right
    @right.left = @left
    @left
  end
end

first_elf = Elf.new
last_elf = first_elf

(INPUT - 1).times do
  new_elf = Elf.new(last_elf)
  last_elf.left = new_elf
  last_elf = new_elf
end

last_elf.left = first_elf
first_elf.right = last_elf

elves = INPUT

current_elf = first_elf
(INPUT / 2).times do
  current_elf = current_elf.left
end

while elves > 1
  current_elf = current_elf.remove
  current_elf = current_elf.left if elves.odd?
  elves -= 1
end

p current_elf.no
