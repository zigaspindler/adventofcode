# --- Part Two ---

# Now find one that starts with six zeroes.

require 'digest'

input = 'iwrupvqb'

output = 0
start = Time.now
loop do
  output += 1
  md5 = Digest::MD5.new
  md5.update input + output.to_s
  break if /^000000/ =~ md5.hexdigest
end

puts output
puts "Time: #{Time.now - start}"
