# --- Part Two ---

# Seeing how reindeer move in bursts, Santa decides he's not pleased with the old scoring system.

# Instead, at the end of each second, he awards one point to the reindeer currently in the lead. (If there are multiple reindeer tied for the lead, they each get one point.) He keeps the traditional 2503 second time limit, of course, as doing otherwise would be entirely ridiculous.

# Given the example reindeer from above, after the first second, Dancer is in the lead and gets one point. He stays in the lead until several seconds into Comet's second burst: after the 140th second, Comet pulls into the lead and gets his first point. Of course, since Dancer had been in the lead for the 139 seconds before that, he has accumulated 139 points by the 140th second.

# After the 1000th second, Dancer has accumulated 689 points, while poor Comet, our old champion, only has 312. So, with the new scoring system, Dancer would win (if the race ended at 1000 seconds).

# Again given the descriptions of each reindeer (in your puzzle input), after exactly 2503 seconds, how many points does the winning reindeer have?

RACE_TIME = 2503

class Reindeer
  attr_reader :distance, :points

  def initialize(name, speed, run_time, rest_time)
    @name = name
    @speed = speed.to_i
    @run_time = run_time.to_i
    @rest_time = rest_time.to_i
    @distance = 0
    @points = 0
  end

  def calculate_distance(time)
    @distance += @speed if time % (@run_time + @rest_time) < @run_time
  end

  def add_point(distance)
    @points += 1 if @distance == distance
  end

end

reindeers = []

File.open('input.txt', 'r').each_line do |line|
  line.chomp.match /^(\w+) .* (\d+) .* (\d+) .* (\d+) .*$/
  reindeers.push Reindeer.new $1, $2, $3, $4
end

(0...RACE_TIME).each do |i|
  reindeers.each { |reindeer| reindeer.calculate_distance(i) }
  longest_distance = reindeers.sort_by { |reindeer| reindeer.distance }[-1].distance
  reindeers.each { |reindeer| reindeer.add_point(longest_distance) }
end

puts reindeers.sort_by { |reindeer| reindeer.points }[-1].points
