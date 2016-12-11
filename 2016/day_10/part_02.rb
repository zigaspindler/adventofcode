# --- Part Two ---

# What do you get if you multiply together the values of one chip in each of outputs 0, 1, and 2?

bot_values = []
bot_instructions = []
output_values = []
inputs = []

File.readlines('input.txt').each do |line|
  command = line.scan(/value (\d+) goes to bot (\d+)/).flatten
  if command.empty?
    bot, low, high = line.scan(/bot (\d+) gives low to ((?:bot|output) \d+) and high to ((?:bot|output) \d+)/).flatten

    low_target, low_position = low.split
    high_target, high_position = high.split

    low_position = low_position.to_i
    high_position = high_position.to_i

    bot = bot.to_i

    bot_instructions[bot] = ->() do
      eval("#{low_target}_values[#{low_position}] = [] unless #{low_target}_values[#{low_position}]")
      eval("#{low_target}_values[#{low_position}] << bot_values[#{bot}].sort.reverse.pop")
      bot_instructions[low_position].call if low_target == 'bot' and bot_values[low_position] and bot_values[low_position].length > 1

      eval("#{high_target}_values[#{high_position}] = [] unless #{high_target}_values[#{high_position}]")
      eval("#{high_target}_values[#{high_position}] << bot_values[#{bot}].sort.pop")
      bot_instructions[high_position].call if high_target == 'bot' and bot_values[high_position] and bot_values[high_position].length > 1
    end
  else
    value, bot = command.map(&:to_i)
    inputs << ->() do
      bot_values[bot] = [] unless bot_values[bot]
      bot_values[bot] << value
      bot_instructions[bot].call if bot_values[bot].length > 1
    end
  end
end

inputs.each{ |i| i.call }

p output_values.flatten[0..2].inject(:*)
