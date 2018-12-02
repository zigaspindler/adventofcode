# --- Part Two ---
# Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

# The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

# abcde
# fghij
# klmno
# pqrst
# fguij
# axcye
# wvxyz
# The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

# What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)

ids = File.readlines('input.txt').map(&:strip)

ids.each_with_index do |id, i|
  possible_ids = ids[i + 1...-1]
  possible_ids.each do |id2|
    diffs = 0
    position = 0
    id.chars.each_with_index do |c, k|
      if c != id2[k]
        diffs += 1 
        position = k
      end
      break if diffs > 1
    end

    if diffs == 1
      id_chars = id.chars
      id_chars.delete_at(position)
      p id_chars.join
      break
    end
  end
end
