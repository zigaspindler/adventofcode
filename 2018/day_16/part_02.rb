# --- Part Two ---
# Using the samples you collected, work out the number of each opcode and execute the test program (the second section of your puzzle input).

# What value is contained in register 0 after executing the test program?

load './opcodes.rb'

counter = 0

mapped = {}
opcodes = OPCODES

while mapped.size < 16
  File.readlines('input_part_01.txt').each_slice(4) do |lines|
    break unless lines.first.start_with?('Before')
  
    _, *before = */(\d+), (\d+), (\d+), (\d+)/.match(lines[0])
    _, *command = */(\d+) (\d+) (\d+) (\d+)/.match(lines[1])
    _, *after = */(\d+), (\d+), (\d+), (\d+)/.match(lines[2])
  
    
    before = before.map(&:to_i)
    command = command.map(&:to_i)
    after = after.map(&:to_i)
    
    local_counter = 0
    local_opcode = nil

    opcodes.each do |opcode|
      result = send(opcode, before.clone, command)
      if result == after
        local_counter += 1
        local_opcode = opcode
      end
      break if local_counter > 1
    end
  
    if local_counter == 1
      mapped[command.first] = local_opcode
      opcodes -= [local_opcode]
    end
  end
end

register = [0, 0, 0, 0]

File.readlines('input_part_02.txt').each do |line|
  _, *command = */(\d+) (\d+) (\d+) (\d+)/.match(line)
  command = command.map(&:to_i)

  send(mapped[command.first], register, command)
end

p register[0]
