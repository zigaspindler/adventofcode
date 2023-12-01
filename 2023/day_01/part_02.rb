# --- Part Two ---
# Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

# Equipped with this new information, you now need to find the real first and last digit on each line. For example:

# two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen
# In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

# What is the sum of all of the calibration values?

word_to_number = proc do |word|
  case word
  when 'one' then 1
  when 'two' then 2
  when 'three' then 3
  when 'four' then 4
  when 'five' then 5
  when 'six' then 6
  when 'seven' then 7
  when 'eight' then 8
  when 'nine' then 9
  else
    word
  end
end

p File.readlines('input.txt').inject(0) { |sum, line|
  line = line.gsub('one', 'o1e')
             .gsub('two', 't2')
             .gsub('three', 't3e')
             .gsub('four', 'f4')
             .gsub('five', 'f5e')
             .gsub('six', 's6')
             .gsub('seven', 's7n')
             .gsub('eight', 'e8t')
             .gsub('nine', 'n9e')
  sum += line.scan(/\d/).values_at(0, -1).join.to_i
}
