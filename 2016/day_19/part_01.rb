# --- Day 19: An Elephant Named Joseph ---

# The Elves contact you over a highly secure emergency channel. Back at the North Pole, the Elves are busy misunderstanding White Elephant parties.

# Each Elf brings a present. They all sit in a circle, numbered starting with position 1. Then, starting with the first Elf, they take turns stealing all the presents from the Elf to their left. An Elf with no presents is removed from the circle and does not take turns.

# For example, with five Elves (numbered 1 to 5):

#   1
# 5   2
#  4 3
# Elf 1 takes Elf 2's present.
# Elf 2 has no presents and is skipped.
# Elf 3 takes Elf 4's present.
# Elf 4 has no presents and is also skipped.
# Elf 5 takes Elf 1's two presents.
# Neither Elf 1 nor Elf 2 have any presents, so both are skipped.
# Elf 3 takes Elf 5's three presents.
# So, with five Elves, the Elf that sits starting in position 3 gets all the presents.

# With the number of Elves given in your puzzle input, which Elf gets all the presents?

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

while elves > 1
  current_elf = current_elf.left.remove
  elves -= 1
end

p current_elf.no
