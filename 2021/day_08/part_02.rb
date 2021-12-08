# --- Part Two ---
# Through a little deduction, you should now be able to determine the remaining digits. Consider again the first example above:

# acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
# cdfeb fcadb cdfeb cdbaf
# After some careful analysis, the mapping between signal wires and segments only make sense in the following configuration:

#  dddd
# e    a
# e    a
#  ffff
# g    b
# g    b
#  cccc
# So, the unique signal patterns would correspond to the following digits:

# acedgfb: 8
# cdfbe: 5
# gcdfa: 2
# fbcad: 3
# dab: 7
# cefabd: 9
# cdfgeb: 6
# eafb: 4
# cagedb: 0
# ab: 1
# Then, the four digits of the output value can be decoded:

# cdfeb: 5
# fcadb: 3
# cdfeb: 5
# cdbaf: 3
# Therefore, the output value for this entry is 5353.

# Following this same process for each entry in the second, larger example above, the output value of each entry can be determined:

# fdgacbe cefdb cefbgd gcbe: 8394
# fcgedb cgb dgebacf gc: 9781
# cg cg fdcagb cbg: 1197
# efabcd cedba gadfec cb: 9361
# gecf egdcabf bgf bfgea: 4873
# gebdcfa ecba ca fadegcb: 8418
# cefg dcbef fcge gbcadfe: 4548
# ed bcgafe cdgba cbgef: 1625
# gbdfcae bgc cg cgb: 8717
# fgae cfgab fg bagce: 4315
# Adding all of the output values in this larger example produces 61229.

# For each entry, determine all of the wire/segment connections and decode the four-digit output values. What do you get if you add up all of the output values?

@decoded_numbers = []

def includes_segment?(number, segment)
  (segment.split('') - number.split('')).empty?
end

def find_number(segment)
  @decoded_numbers.each_with_index do |d, i|
    next unless segment.size == d.size
    return i if (d.split('') - segment.split('')).empty?
  end
end

sum = 0

File.readlines('input.txt').each do |line|
  pattern, output = line.split(' | ')
  numbers = pattern.split(' ')

  # 1
  numbers.delete_if { |v| @decoded_numbers[1] = v if v.size == 2 }
  # 4
  numbers.delete_if { |v| @decoded_numbers[4] = v if v.size == 4 }
  # 7
  numbers.delete_if { |v| @decoded_numbers[7] = v if v.size == 3 }
  # 8
  numbers.delete_if { |v| @decoded_numbers[8] = v if v.size == 7 }
  # 3
  numbers.delete_if { |v| @decoded_numbers[3] = v if v.size == 5 && includes_segment?(v, @decoded_numbers[1]) }
  # 9
  numbers.delete_if { |v| @decoded_numbers[9] = v if v.size == 6 && includes_segment?(v, @decoded_numbers[3]) }
  # 0
  numbers.delete_if { |v| @decoded_numbers[0] = v if v.size == 6 && includes_segment?(v, @decoded_numbers[1]) }
  # 6
  numbers.delete_if { |v| @decoded_numbers[6] = v if v.size == 6 }
  # 5
  numbers.delete_if { |v| @decoded_numbers[5] = v if includes_segment?(@decoded_numbers[6], v) }
  # 2
  @decoded_numbers[2] = numbers.first

  sum += output.strip.split(' ').map { |o| find_number(o) }.join.to_i
end

p sum
