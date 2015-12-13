# --- Part Two ---

# In all the commotion, you realize that you forgot to seat yourself. At this point, you're pretty apathetic toward the whole thing, and your happiness wouldn't really go up or down regardless of who you sit next to. You assume everyone else would be just as ambivalent about sitting next to you, too.

# So, add yourself to the list, and give all happiness relationships that involve you a score of 0.

# What is the total change in happiness for the optimal seating arrangement that actually includes yourself?

people = []
relations = Hash.new

File.open('input.txt', 'r').each_line do |line|
  line.chomp.match /^(\w+).*(gain|lose) (\d*).* (\w+).$/
  people << $1 unless people.include? $1
  people << $4 unless people.include? $4
  relations[[$1, $4]] = $2 == 'gain' ? $3.to_i : -$3.to_i
end

people.each { |person| relations[['Me', person]], relations[[person, 'Me']] = 0, 0 }

puts people.permutation.map { |seating|
  seating.unshift 'Me'
  happiness = 0
  (0...seating.length).each do |i|
    happiness += relations[[seating[i], seating[(i + 1) % seating.length]]] + relations[[seating[i], seating[(i - 1) % seating.length]]]
  end
  happiness
}.sort[-1]
