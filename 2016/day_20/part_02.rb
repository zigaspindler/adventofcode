# --- Part Two ---

# How many IPs are allowed by the blacklist?

blocked = []
ip = 0
ips = 0

File.readlines('input.txt').each do |line|
  start, finish = line.split('-')
  blocked << [start.to_i, finish.to_i]
  ip = finish.to_i if start.to_i == 0
end

while ip < 2**32
  valid = true

  blocked.each do |b|
    if ip >= b[0] and ip <= b[1]
      ip = b[1]
      valid = false
      break
    end
  end

  ips += 1 if valid

  ip += 1
end

p ips
