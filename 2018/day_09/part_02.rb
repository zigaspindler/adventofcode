# --- Part Two ---
# Amused by the speed of your answer, the Elves are curious:

# What would the new winning Elf's score be if the number of the last marble were 100 times larger?

class Node
  attr_accessor :value, :prev, :next

  def initialize(value, prev, nxt)
    @value = value
    @prev = prev || self
    @next = nxt || self
  end

  def insert_after(value)
    new_node = Node.new(value, self, @next)
    @next.prev = new_node
    @next = new_node
    new_node
  end

  def delete
    @prev.next = @next
    @next.prev = @prev
    @next
  end
end

input = '410 players; last marble is worth 72059 points'

_, players, max_points = * /(\d+).+worth (\d+) .+/.match(input)

players = players.to_i
players_score = Hash.new(0)
current_marble = Node.new(0, nil, nil)

(max_points.to_i * 100).times do |i|
  marble = i + 1
  if marble % 23 == 0
    marble_to_remove = current_marble.prev.prev.prev.prev.prev.prev.prev
    current_player = i % players
    players_score[current_player] += (marble + marble_to_remove.value)
    current_marble = marble_to_remove.delete
  else
    current_marble = current_marble.next.insert_after(marble)
  end
end

p players_score.values.max
