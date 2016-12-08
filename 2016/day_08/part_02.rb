# --- Part Two ---

# You notice that the screen is only capable of displaying capital letters; in the font it uses, each letter is 5 pixels wide and 6 tall.

# After you swipe your card, what code is the screen trying to display?

HEIGHT = 6
WIDTH = 50
@screen = Array.new(HEIGHT) { Array.new(WIDTH, ' ') }

def rect(params)
  width, height = params.scan(/^(\d+)x(\d+)$/).flatten.map(&:to_i)
  for i in 0...height
    @screen[i].fill('#', 0...width)
  end
end

def rotate(params)
  command, params = params.scan(/^([a-z]+) (.*)/).flatten
  send("rotate_#{command}", params)
end

def rotate_column(params)
  column, by = params.scan(/^x=(\d+) by (\d+)/).flatten.map(&:to_i)
  screen_clone = @screen.map(&:clone)
  
  for i in 0...HEIGHT
    @screen[i][column] = screen_clone[(i - by) % HEIGHT][column]
  end
end

def rotate_row(params)
  column, by = params.scan(/^y=(\d+) by (\d+)/).flatten.map(&:to_i)
  @screen[column].rotate!(-by)
end

File.readlines('input.txt').map do |line|
  command, params = line.scan(/^([a-z]+) (.*)/).flatten
  send(command, params)
end

puts @screen.map(&:join)
