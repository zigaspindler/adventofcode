class Intcode
  def initialize(opcodes, input: [], output: [])
    @opcodes = opcodes
    @input = input
    @output = output
    @position = 0
    @relative_base = 0
  end

  def run
    loop do
      command = @opcodes.slice(@position, 4)

      break if command[0] == 99
    
      case command[0].digits.first
      when 1
        add(command)
      when 2
        multiply(command)
      when 3
        padded = sprintf('%05d', command[0].to_s)
        pos = get_relative(padded[2], command[1])
        @opcodes[pos] = @input.shift
        @position += 2
      when 4
        a, _, _ = get_params(command)
        @position += 2
        @output.push(a)
      when 5
        jump_if_true(command)
      when 6
        jump_if_false(command)
      when 7
        less_than(command)
      when 8
        equals(command)
      when 9
        increase_relative(command)
      else
        break
      end
    end
  end

  private

  def add(command)
    a, b, target = get_params(command)
    @opcodes[target] = a + b
    @position += 4
  end
  
  def multiply(command)
    a, b, target = get_params(command)
    @opcodes[target] = a * b
    @position += 4
  end
  
  def jump_if_true(command)
    a, b, _ = get_params(command)
    @position = a != 0 ? b : (@position + 3)
  end
  
  def jump_if_false(command)
    a, b, _ = get_params(command)
    @position = a == 0 ? b : (@position + 3)
  end
  
  def less_than(command)
    a, b, target = get_params(command)
    @opcodes[target] = a < b ? 1 : 0
    @position += 4
  end
  
  def equals(command)
    a, b, target = get_params(command)
    @opcodes[target] = a == b ? 1 : 0
    @position += 4
  end

  def increase_relative(command)
    a, _, _ = get_params(command)
    @relative_base += a
    @position += 2
  end
  
  def get_params(command)
    padded = sprintf('%05d', command[0].to_s)

    a = get_value(padded[2], command[1])
    b = get_value(padded[1], command[2])
    target = get_relative(padded[0], command[3])
  
    return a, b, target
  end

  def get_value(mode, pos)
    value = case mode
      when '0'
        @opcodes[pos]
      when '1'
        pos
      when '2'
        @opcodes[@relative_base + pos]
      end

    value || 0
  end

  def get_relative(mode, pos)
    return pos if mode != '2'

    @relative_base + pos
  end
end
