# --- Part Two ---

# The Elves decide they don't want to visit an infinite number of houses. Instead, each Elf will stop after delivering presents to 50 houses. To make up for it, they decide to deliver presents equal to eleven times their number at each house.

# With these changes, what is the new lowest house number of the house to get at least as many presents as the number in your puzzle input?
input = 34000000

def visiting_elves(house)
  elves = []
  (1..Math.sqrt(house)).each do |i|
    if house % i == 0
      elves << i << house / i
    end
  end
  elves.uniq.reject { |i| house / i > 50 }
end

def get_presents(house)
  presents = 0
  visiting_elves(house).each do |i|
    presents += 11 * i
  end
  presents
end

house = 0
loop do
  house += 1
  break unless get_presents(house) < input
end

puts house
