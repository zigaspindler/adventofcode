# --- Part Two ---
# Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

# For example, in the claims above, only claim 3 is intact after all claims are made.

# What is the ID of the only claim that doesn't overlap?

class Claim
  attr_accessor :id, :x1, :x2, :y1, :y2, :overlap
  def initialize(string)
    match = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/.match(string.strip)
    @id = match[1].to_i
    @x1 = match[2].to_i + 1
    @x2 = @x1 + match[4].to_i
    @y1 = match[3].to_i + 1
    @y2 = @y1 + match[5].to_i
    @overlap = false
  end

  def overlaping?(claim)
    if @x2 < claim.x1 || @y2 < claim.y1 || @x1 > claim.x2 || @y1 > claim.y2
      return false
    end

    @overlap = true
    claim.overlap = true
  end
end

claims = File.readlines('input.txt').map{ |line| Claim.new(line) }

claims.each_with_index do |claim_1, i|
  claims[i + 1..-1].each do |claim_2|
    claim_1.overlaping?(claim_2)
  end
end

p claims.select{ |c| !c.overlap }.first.id
