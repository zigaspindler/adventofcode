# --- Part Two ---
# Now that you have the structure of your transmission decoded, you can calculate the value of the expression it represents.

# Literal values (type ID 4) represent a single number as described above. The remaining type IDs are more interesting:

# Packets with type ID 0 are sum packets - their value is the sum of the values of their sub-packets. If they only have a single sub-packet, their value is the value of the sub-packet.
# Packets with type ID 1 are product packets - their value is the result of multiplying together the values of their sub-packets. If they only have a single sub-packet, their value is the value of the sub-packet.
# Packets with type ID 2 are minimum packets - their value is the minimum of the values of their sub-packets.
# Packets with type ID 3 are maximum packets - their value is the maximum of the values of their sub-packets.
# Packets with type ID 5 are greater than packets - their value is 1 if the value of the first sub-packet is greater than the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
# Packets with type ID 6 are less than packets - their value is 1 if the value of the first sub-packet is less than the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
# Packets with type ID 7 are equal to packets - their value is 1 if the value of the first sub-packet is equal to the value of the second sub-packet; otherwise, their value is 0. These packets always have exactly two sub-packets.
# Using these rules, you can now work out the value of the outermost packet in your BITS transmission.

# For example:

# C200B40A82 finds the sum of 1 and 2, resulting in the value 3.
# 04005AC33890 finds the product of 6 and 9, resulting in the value 54.
# 880086C3E88112 finds the minimum of 7, 8, and 9, resulting in the value 7.
# CE00C43D881120 finds the maximum of 7, 8, and 9, resulting in the value 9.
# D8005AC2A8F0 produces 1, because 5 is less than 15.
# F600BC2D8F produces 0, because 5 is not greater than 15.
# 9C005AC2F8F0 produces 0, because 5 is not equal to 15.
# 9C0141080250320F1802104A08 produces 1, because 1 + 3 = 2 * 2.
# What do you get if you evaluate the expression represented by your hexadecimal-encoded BITS transmission?

def process_packet(packet)
  version = packet.slice!(0...3).to_i(2)
  type = packet.slice!(0...3).to_i(2)

  if type == 4
    process_literal(packet).to_i(2)
  else
    values = process_operator(packet, type)
    process_operation(values, type)
  end
end

def process_literal(packet)
  start_bit = packet.slice!(0)
  value = packet.slice!(0...4)

  return value if start_bit == '0'

  value + process_literal(packet)
end

def process_operator(packet, _type)
  length_type = packet.slice!(0)
  values = []

  if length_type == '0'
    length = packet.slice!(0...15).to_i(2)

    sub_packets = packet.slice!(0...length)
    values << process_packet(sub_packets) while sub_packets.size > 0
  else
    no_packets = packet.slice!(0...11).to_i(2)
    no_packets.times do
      values << process_packet(packet)
    end
  end
  values
end

def process_operation(values, type)
  case type
  when 0
    values.inject(:+)
  when 1
    values.inject(:*)
  when 2
    values.min
  when 3
    values.max
  when 5
    values[0] > values[1] ? 1 : 0
  when 6
    values[0] < values[1] ? 1 : 0
  when 7
    values[0] == values[1] ? 1 : 0
  end
end

input = File.read('input.txt').strip.chars.map { |c| c.hex.to_s(2).rjust(4, '0') }.join

p process_packet(input)
