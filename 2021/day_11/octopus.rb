class Octopus
  attr_reader :power, :flashed

  def initialize(power)
    @power = power
    @flashed = false
  end

  def increase_power
    @power += 1
  end

  def flash!
    return false if flashed || power < 10

    @flashed = true
  end

  def reset
    return unless flashed

    @flashed = false
    @power = 0
  end

  def flashed?
    flashed
  end
end