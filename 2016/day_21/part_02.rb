# --- Part Two ---

# You scrambled the password correctly, but you discover that you can't actually modify the password file on the system. You'll need to un-scramble one of the existing passwords by reversing the scrambling process.

# What is the un-scrambled version of the scrambled password fbgdceah?

@password = 'fbgdceah'
instructions = []

def swap(args)
  instruction, args = args.scan(/^([a-z]+) (.+)/).flatten
  send("swap_#{instruction}", args)
end

def swap_position(args)
  x, y = args.scan(/(\d) with position (\d)/).flatten.map(&:to_i)
  @password[x], @password[y] = @password[y], @password[x]
end

def swap_letter(args)
  x, y = args.scan(/([a-z]) with letter ([a-z])/).flatten.map{ |c| @password.index c }
  @password[x], @password[y] = @password[y], @password[x]
end

def reverse(args)
  x, y = args.scan(/positions (\d) through (\d)/).flatten.map(&:to_i)
  reversed = @password[x..y].reverse
  @password = @password[0, x] + reversed + @password[(y + 1)...@password.length ]
end

def rotate(args)
  instruction, args = args.scan(/^([a-z]+) (.+)/).flatten
  send("rotate_#{instruction}", args)
end

def rotate_left(args)
  step = args.scan(/(\d)/).flatten.first.to_i
  @password = @password.chars.rotate(-step).join
end

def rotate_right(args)
  step = args.scan(/(\d)/).flatten.first.to_i
  @password = @password.chars.rotate(step).join
end

def rotate_based(args)
  c = args.scan(/on position of letter ([a-z])/).flatten.first
  i = @password.index c
  step = i / 2 + (i.odd? || i == 0 ? 1 : 5)
  @password = @password.chars.rotate(step).join
end

def move(args)
  x, y = args.scan(/position (\d) to position (\d)/).flatten.map(&:to_i)
  c = @password.slice! y
  @password.insert(x, c)
end

File.readlines('input.txt').each do |line|
  instructions << line.scan(/^([a-z]+) (.+)/).flatten
end

instructions.reverse.each do |instruction|
  send(instruction[0], instruction[1])
end

p @password
