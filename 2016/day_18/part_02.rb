# --- Part Two ---

# How many safe tiles are there in a total of 400000 rows?

INPUT = '.^^..^...^..^^.^^^.^^^.^^^^^^.^.^^^^.^^.^^^^^^.^...^......^...^^^..^^^.....^^^^^^^^^....^^...^^^^..^'
ROWS = 400000

counter = 0

line = INPUT
counter = line.chars.select{ |c| c == '.' }.count

def trap?(line)
  %w( ^^. .^^ ^.. ..^ ).include? line
end

(ROWS - 1).times do
  temp_line = ''
  for i in 0...INPUT.length
    chars = ''

    if i == 0
      chars = '.' + line.slice(0, 2)
    elsif i == INPUT.length - 1
      chars = line.slice(i - 1, 2) + '.'
    else
      chars = line.slice(i - 1, 3)
    end
    
    if trap?(chars)
      temp_line += '^'
    else
      temp_line += '.'
      counter += 1
    end
  end
  line = temp_line
end

p counter
