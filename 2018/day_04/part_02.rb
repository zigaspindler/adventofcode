
# Your puzzle answer was 71748.

# The first half of this puzzle is complete! It provides one gold star: *

# --- Part Two ---
# Strategy 2: Of all guards, which guard is most frequently asleep on the same minute?

# In the example above, Guard #99 spent minute 45 asleep more than any other guard or minute - three times in total. (In all other cases, any guard spent any minute asleep at most twice.)

# What is the ID of the guard you chose multiplied by the minute you chose? (In the above example, the answer would be 99 * 45 = 4455.)

class Guard
  attr_accessor :id, :minutes

  def initialize(id)
    @id = id
    @minutes = Array.new(60, 0)
  end

  def add_minutes(start, stop)
    (start.to_i...stop.to_i).each{ |i| @minutes[i] += 1 }
  end

  def sorting
    @sorting ||= @minutes.max
  end

  def to_s
    minutes.each_with_index.max[1] * id.to_i
  end
end

guards = {}
current_guard = nil
current_start = nil

lines = File.readlines('input.txt').sort.each do |line|
  _, minutes, id, action = * /\[.+:(\d\d)\](?:.+#(\d+).+| (.+) .+)/.match(line.strip)

  if id # new guard
    current_guard = guards[id] ||= Guard.new(id)
  else
    if action == 'falls'
      current_start = minutes
    else
      current_guard.add_minutes(current_start, minutes)
    end
  end
end

p guards.sort_by{ |k, v| -v.sorting }.first[1].to_s
