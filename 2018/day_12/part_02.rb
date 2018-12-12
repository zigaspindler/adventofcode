# --- Part Two ---
# You realize that 20 generations aren't enough. After all, these plants will need to last another 1500 years to even reach your timeline, not to mention your future.

# After fifty billion (50000000000) generations, what is the sum of the numbers of all pots which contain a plant?

initial_state = '#......##...#.#.###.#.##..##.#.....##....#.#.##.##.#..#.##........####.###.###.##..#....#...###.##'

rules = {}

File.readlines('input.txt').each do |line|
  _, k, v = * /(.+) => (.)/.match(line.strip)
  rules[k] = v
end

current_state = "#{initial_state}.".chars.each_with_index.map{ |c, i| [i, c] }.to_h
previous = 0

200.times do |i|
  temp_hash = {}
  current_state.each do |k, v|
    pattern = (k - 2..k + 2).map{ |i| current_state[i] ? current_state[i] : temp_hash[i] = '.' }.join

    temp_hash[k] = rules.fetch(pattern, '.')
  end
  current_state = temp_hash
end

first_200 =  current_state.map{ |k, v| v == '#' ? k : 0 }.inject(:+)

# after 169 it starts to add 75 on each new generation
p (50_000_000_000 - 200) * 75 + first_200
