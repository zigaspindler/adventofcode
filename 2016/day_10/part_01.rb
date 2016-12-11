# --- Day 10: Balance Bots ---

# You come upon a factory in which many robots are zooming around handing small microchips to each other.

# Upon closer examination, you notice that each bot only proceeds when it has two microchips, and once it does, it gives each one to a different bot or puts it in a marked "output" bin. Sometimes, bots take microchips from "input" bins, too.

# Inspecting one of the microchips, it seems like they each contain a single number; the bots must use some logic to decide what to do with each chip. You access the local control computer and download the bots' instructions (your puzzle input).

# Some of the instructions specify that a specific-valued microchip should be given to a specific bot; the rest of the instructions indicate what a given bot should do with its lower-value or higher-value chip.

# For example, consider the following instructions:

# value 5 goes to bot 2
# bot 2 gives low to bot 1 and high to bot 0
# value 3 goes to bot 1
# bot 1 gives low to output 1 and high to bot 0
# bot 0 gives low to output 2 and high to output 0
# value 2 goes to bot 2
# Initially, bot 1 starts with a value-3 chip, and bot 2 starts with a value-2 chip and a value-5 chip.
# Because bot 2 has two microchips, it gives its lower one (2) to bot 1 and its higher one (5) to bot 0.
# Then, bot 1 has two microchips; it puts the value-2 chip in output 1 and gives the value-3 chip to bot 0.
# Finally, bot 0 has two microchips; it puts the 3 in output 2 and the 5 in output 0.
# In the end, output bin 0 contains a value-5 microchip, output bin 1 contains a value-2 microchip, and output bin 2 contains a value-3 microchip. In this configuration, bot number 2 is responsible for comparing value-5 microchips with value-2 microchips.

# Based on your instructions, what is the number of the bot that is responsible for comparing value-61 microchips with value-17 microchips?

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

for i in 0...bot_values.length
  p i if bot_values[i].sort == [17, 61]
end
