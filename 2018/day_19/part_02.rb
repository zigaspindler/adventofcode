# --- Part Two ---
# A new background process immediately spins up in its place. It appears identical, but on closer inspection, you notice that this time, register 0 started with the value 1.

# What value is left in register 0 when this new background process halts?

load './opcodes.rb'

lines = File.readlines('input.txt')

_, ip = */#ip (\d)/.match(lines.delete_at(0))

ip = ip.to_i
instructions = lines.map do |line|
  _, instruction, a, b, c = */(.+) (\d+) (\d+) (\d+)/.match(line.strip)
  [instruction, a.to_i, b.to_i, c.to_i]
end

register = [1, 0, 0, 0, 0, 0]
ip_value = 0

# the input is looking for all the dividers of the number in register 2 and then sums them up
20.times do
  register[ip] = ip_value
  instruction, *values = instructions[ip_value]
  send(instruction, register, *values)
  ip_value = register[ip] + 1
end

p (1..register[2]).select{ |i| register[2] % i == 0 }.sum
