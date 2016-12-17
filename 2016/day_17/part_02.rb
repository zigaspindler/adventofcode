# --- Part Two ---

# You're curious how robust this security solution really is, and so you decide to find longer and longer paths which still provide access to the vault. You remember that paths always end the first time they reach the bottom-right room (that is, they can never pass through it, only end in it).

# For example:

# If your passcode were ihgpwlah, the longest path would take 370 steps.
# With kglvqrro, the longest path would be 492 steps long.
# With ulqzkmiv, the longest path would be 830 steps long.
# What is the length of the longest path that reaches the vault?

require 'digest'

INPUT = 'ioramepc'
VALID_CHARS = %w( b c d e f )
FINISH = [3, 3]

def possible_paths(position, path = '')
  hex = Digest::MD5.hexdigest INPUT + path

  paths = []

  if VALID_CHARS.include?(hex[0]) and position[0] - 1 >= 0
    paths << { position: [position[0] - 1, position[1]], path: path + 'U' }
  end

  if VALID_CHARS.include?(hex[1]) and position[0] + 1 < 4
    paths << { position: [position[0] + 1, position[1]], path: path + 'D' }
  end

  if VALID_CHARS.include?(hex[2]) and position[1] - 1 >= 0
    paths << { position: [position[0], position[1] - 1], path: path + 'L' }
  end

  if VALID_CHARS.include?(hex[3]) and position[1] + 1 < 4
    paths << { position: [position[0], position[1] + 1], path: path + 'R' }
  end
  
  paths
end

paths = possible_paths([0, 0])
finished_paths = []

while paths.any?
  paths.sort_by!{ |p| p[:path].length }
  path = paths.shift

  if path[:position] == FINISH
    finished_paths << path[:path]
  else
    paths << possible_paths(path[:position], path[:path])
    paths.flatten!
  end
end

p finished_paths.sort_by!{ |p| p.length }.reverse.first.length
