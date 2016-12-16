# --- Part Two ---

# The second disk you have to fill has length 35651584. Again using the initial state in your puzzle input, what is the correct checksum for this disk?

INPUT = '01110110101001000'
LENGTH = 35651584

data = INPUT

while data.length < LENGTH
  b = data.reverse.chars.map{ |c| c == '0' ? '1' : '0' }.join
  data = "#{data}0#{b}"
end

data = data[0..LENGTH - 1]

while data.length.even?
  data = data.chars.each_slice(2).to_a.map{ |a| a.join == a.join.reverse ? '1' : '0' }.join
end

p data
