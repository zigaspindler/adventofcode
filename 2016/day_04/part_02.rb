# --- Part Two ---

# With all the decoy data out of the way, it's time to decrypt this list and get moving.

# The room names are encrypted by a state-of-the-art shift cipher, which is nearly unbreakable without the right software. However, the information kiosk designers at Easter Bunny HQ were not expecting to deal with a master cryptographer like yourself.

# To decrypt a room name, rotate each letter forward through the alphabet a number of times equal to the room's sector ID. A becomes B, B becomes C, Z becomes A, and so on. Dashes become spaces.

# For example, the real name for qzmt-zixmtkozy-ivhz-343 is very encrypted name.

# What is the sector ID of the room where North Pole objects are stored?

alphabet = ('a'..'z').to_a

File.readlines('input.txt').each do |line|
  name, id, checksum = line.scan(/(.+)([0-9]{3})\[([a-z]{5})\]/).flatten

  chars_hash = {}
  name.gsub(/-/, '').chars.each do |c|
    chars_hash[c] = 0 unless chars_hash.key?(c)
    chars_hash[c] += 1
  end

  if Hash[chars_hash.sort_by{ |k, v| [-v, k] }[0..4]].keys.join == checksum
    rotated_alphabet = alphabet.rotate(id.to_i)
    
    if name.each_byte.map { |c| c == 45 ? ' ' : rotated_alphabet[c - 97] }.join.strip == 'northpole object storage'
      puts id
      break
    end
  end
end

