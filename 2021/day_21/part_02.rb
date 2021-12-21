# --- Part Two ---
# Now that you're warmed up, it's time to play the real game.

# A second compartment opens, this time labeled Dirac dice. Out of it falls a single three-sided die.

# As you experiment with the die, you feel a little strange. An informational brochure in the compartment explains that this is a quantum die: when you roll it, the universe splits into multiple copies, one copy for each possible outcome of the die. In this case, rolling the die always splits the universe into three copies: one where the outcome of the roll was 1, one where it was 2, and one where it was 3.

# The game is played the same as before, although to prevent things from getting too far out of hand, the game now ends when either player's score reaches at least 21.

# Using the same starting positions as in the example above, player 1 wins in 444356092776315 universes, while player 2 merely wins in 341960390180808 universes.

# Using your given starting positions, determine every possible outcome. Find the player that wins in more universes; in how many universes does that player win?

@cache = {}
# with 3 dies you can only get 7 different outcomes. each outcome can be achieved
# multiple ways: 3 for isntance only in 1 way, 4 in 3 ways, etc.
OUTCOMES = { 3 => 1, 4 => 3, 5 => 6, 6 => 7, 7 => 6, 8 => 3, 9 => 1 }.freeze

def next_spot(pos, roll)
  new_pos = pos + roll
  new_pos -= 10 if new_pos > 10
  new_pos
end

def roll(p1, p2, s1, s2, turn)
  if s1 >= 21
    return 1
  elsif s2 >= 21
    return 1.i
  end

  output = @cache[[p1, p2, s1, s2, turn]]

  return output if output

  output = 0

  if turn == 1
    OUTCOMES.each { |k, v| output += roll(next_spot(p1, k), p2, s1 + next_spot(p1, k), s2, 2) * v }
  elsif turn == 2
    OUTCOMES.each { |k, v| output += roll(p1, next_spot(p2, k), s1, s2 + next_spot(p2, k), 1) * v }
  end
  @cache[[p1, p2, s1, s2, turn]] = output
  output
end

p1, p2 = File.read('input.txt').split("\n").map { |l| l.split(' ').last.to_i }
roll(p1, p2, 0, 0, 1).tap { p [_1.real, _1.imaginary].max }
