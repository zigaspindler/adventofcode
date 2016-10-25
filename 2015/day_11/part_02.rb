# --- Part Two ---

# Santa's password expired again. What's the next one?

input = 'vzbxxyzz'.next # output of part 1

rules = Regexp.union ('a'..'z').each_cons(3).map(&:join)

input.next! until input !~ /[iol]/ and input =~ /\w*(?:(\w)\1\w*){2,}/ and input =~ rules

puts input
