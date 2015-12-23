# --- Part Two ---

# Turns out the shopkeeper is working with the boss, and can persuade you to buy whatever items he wants. The other rules still apply, and he still only has one of each item.

# What is the most amount of gold you can spend and still lose the fight?

require_relative 'store'

@enemy = {
  hit_points: 109,
  damage: 8,
  armor: 2
}

@player = {
  hit_points: 100,
  damage: 0,
  armor: 0,
  cost: 0
}

@highest_cost = 0

def number_of_assaults(player)
  damage = player[:damage] - @enemy[:armor]
  damage = 1 if damage < 1
  (@enemy[:hit_points].to_f / damage.to_f).ceil
end

def winner?(player)
  damage = @enemy[:damage] - player[:armor]
  damage = 1 if damage < 1
  player[:hit_points] - ((number_of_assaults(player) - 1) * damage) > 0
end

@store[:weapons].each do |weapon|
  player_with_weapon = @player.clone
  player_with_weapon[:damage] += weapon[:damage]
  player_with_weapon[:cost] += weapon[:cost]
  @store[:armor].combination(1).each do |armor|
    player_with_armor = player_with_weapon.clone
    player_with_armor[:armor] += armor.first[:armor]
    player_with_armor[:cost] += armor.first[:cost]

    @store[:rings].combination(2).each do |rings|
      player_with_rings = player_with_armor.clone
      rings.each do |ring|
        player_with_rings[:armor] += ring[:armor]
        player_with_rings[:damage] += ring[:damage]
        player_with_rings[:cost] += ring[:cost]
      end
      @highest_cost = player_with_rings[:cost] if player_with_rings[:cost] > @highest_cost and !winner?(player_with_rings)
    end
  end
end

puts @highest_cost
