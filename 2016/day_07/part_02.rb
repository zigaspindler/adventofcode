# --- Part Two ---

# You would also like to know which IPs support SSL (super-secret listening).

# An IP supports SSL if it has an Area-Broadcast Accessor, or ABA, anywhere in the supernet sequences (outside any square bracketed sections), and a corresponding Byte Allocation Block, or BAB, anywhere in the hypernet sequences. An ABA is any three-character sequence which consists of the same character twice with a different character between them, such as xyx or aba. A corresponding BAB is the same characters but in reversed positions: yxy and bab, respectively.

# For example:

# aba[bab]xyz supports SSL (aba outside square brackets with corresponding bab within square brackets).
# xyx[xyx]xyx does not support SSL (xyx, but no corresponding yxy).
# aaa[kek]eke supports SSL (eke in supernet with corresponding kek in hypernet; the aaa sequence is not related, because the interior character must be different).
# zazbz[bzb]cdb supports SSL (zaz has no corresponding aza, but zbz has a corresponding bzb, even though zaz and zbz overlap).
# How many IPs in your puzzle input support SSL?

counter = 0

check_aba = ->(sec) do
  list = []
  for i in 0...(sec.length - 2)
    list << sec[i..(i+2)] if sec[i] == sec[i + 2] and sec[i] != sec[i + 1]
  end
  list
end

File.readlines('input.txt').map do |line|
  aba_sections = line.scan(/([a-z]+)(?:\[[a-z]+\])?/).flatten.map(&check_aba).flatten
  bab_sections = line.scan(/\[([a-z]+)\]/).flatten

  results = []
  aba_sections.each do |aba_sec|
    bab_sec = aba_sec[1] + aba_sec[0] + aba_sec[1]
    results << bab_sections.map{ |b| b.include? bab_sec }.any?
  end

  counter += 1 if results.any?
end

puts counter
