# --- Part Two ---
# As it turns out, you got the Elves' plan backwards. They actually want to know how many recipes appear on the scoreboard to the left of the first recipes whose scores are the digits from your puzzle input.

# 51589 first appears after 9 recipes.
# 01245 first appears after 5 recipes.
# 92510 first appears after 18 recipes.
# 59414 first appears after 2018 recipes.
# How many recipes appear on the scoreboard to the left of the score sequence in your puzzle input?

input = 327901
input_length = input.digits.size
input_string = input.to_s

scores = { 0 => 3, 1 => 7 }
positions = [0, 1]

last = '37'

1.step do |i|
  new_score = (scores[positions[0]] + scores[positions[1]]).digits.reverse
  new_score.each{ |s| scores[scores.size] = s }
  last += new_score.join
  while last.size > input_length + 1
    last = last[1..-1]
  end
  positions[0] = (positions[0] + 1 + scores[positions[0]]) % scores.length
  positions[1] = (positions[1] + 1 + scores[positions[1]]) % scores.length
  break if /#{input}/.match(last)
end

p scores.count - input_length - (1 - (/#{input}/ =~ last))
