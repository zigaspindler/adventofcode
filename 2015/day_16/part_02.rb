# --- Part Two ---

# As you're about to send the thank you note, something in the MFCSAM's instructions catches your eye. Apparently, it has an outdated retroencabulator, and so the output from the machine isn't exact values - some of them indicate ranges.

# In particular, the cats and trees readings indicates that there are greater than that many (due to the unpredictable nuclear decay of cat dander and tree pollen), while the pomeranians and goldfish readings indicate that there are fewer than that many (due to the modial interaction of magnetoreluctance).

# What is the number of the real Aunt Sue?

aunt = {
  children: { value: 3, operator: '==' },
  cats: { value: 7, operator: '<' },
  samoyeds: { value: 2, operator: '==' },
  pomeranians: { value: 3, operator: '>' },
  akitas: { value: 0, operator: '==' },
  vizslas: { value: 0, operator: '==' },
  goldfish: { value: 5, operator: '>' },
  trees: { value: 3, operator: '<' },
  cars: { value: 2, operator: '==' },
  perfumes: { value: 1, operator: '==' },
}

File.open('input.txt', 'r').each_line.with_index do |line, i|
  found = true
  
  line.scan(/(?:(\w+): (\d+))/).each do |prop|
    p = aunt[prop[0].to_sym]
    unless eval "#{p[:value]} #{p[:operator]} #{prop[1].to_i}"
      found = false
      break
    end
  end

  if found
    puts i + 1
    break
  end
end
