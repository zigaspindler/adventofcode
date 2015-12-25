# --- Part Two ---

# On the next run through the game, you increase the difficulty to hard.

# At the start of each player turn (before any other effects apply), you lose 1 hit point. If this brings you to or below 0 hit points, you lose.

# With the same starting stats for you and the boss, what is the least amount of mana you can spend and still win the fight?

spells = [
  {
    cost: 53,
    duration: 1
  },
  {
    cost: 73,
    duration: 1
  },
  {
    cost: 113,
    duration: 6
  },
  {
    cost: 173,
    duration: 6
  },
  {
    cost: 229,
    duration: 5
  }
]

nodes = [
  {
    player_hp: 50,
    player_mana: 500,
    player_armor: 0,
    enemy_hp: 55,
    enemy_damage: 8,
    mana_spent: 0,
    spell_timers: [0, 0, 0, 0, 0],
    player_turn: true
  }
]

@lowest_mana = 9999

until nodes.empty? do
  node = nodes.shift

  node[:player_hp] -= 1 if node[:player_turn]

  next unless node[:player_hp] > 0

  node[:player_armor] = 0

  spells.each.with_index do |spell, i|
    if node[:spell_timers][i] > 0
      node[:spell_timers][i] -= 1

      case i
      when 0
        node[:enemy_hp] -= 4
      when 1
        node[:enemy_hp] -= 2
        node[:player_hp] += 0
      when 2
        node[:player_armor] = 7
      when 3
        node[:enemy_hp] -= 3
      when 4
        node[:player_mana] += 101
      end
    end
  end

  unless node[:enemy_hp] > 0
    @lowest_mana = [@lowest_mana, node[:mana_spent]].min
    puts "nodes: #{nodes.length}, mana: #{@lowest_mana}"
    next
  end

  if node[:player_turn]
    spells.each.with_index do |spell, i|
      if node[:spell_timers][i] == 0 and node[:player_mana] >= spell[:cost]
        new_node = Marshal.load(Marshal.dump(node))
        new_node[:spell_timers][i] = spell[:duration]
        new_node[:player_mana] -= spell[:cost]
        new_node[:mana_spent] += spell[:cost]
        new_node[:player_turn] = false
        nodes << new_node if new_node[:mana_spent] < @lowest_mana
      end
    end
  else
    node[:player_hp] -= [1, node[:enemy_damage] - node[:player_armor]].max
    node[:player_turn] = true
    nodes << node
  end
end

puts @lowest_mana
