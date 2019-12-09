class Intcode
  def initialize(opcodes, input: [], output: [])
    @opcodes = opcodes.dup
    @position = 0
    @input = input
    @output = output
  end

  def run
    loop do
      command = @opcodes.slice(@position, 4)
    
      case command[0].digits.first
      when 1
        add(command)
        @position += 4
      when 2
        multiply(command)
        @position += 4
      when 3
        @opcodes[command[1]] = @input.shift
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
        @position += 4
      when 8
        equals(command)
        @position += 4
      else
        break
      end
    end
  end

  private

  def add(command)
    a, b, target = get_params(command)
    @opcodes[target] = a + b
  end
  
  def multiply(command)
    a, b, target = get_params(command)
    @opcodes[target] = a * b
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
  end
  
  def equals(command)
    a, b, target = get_params(command)
    @opcodes[target] = a == b ? 1 : 0
  end
  
  def get_params(command)
    padded = sprintf('%05d', command[0].to_s)
  
    a = padded[2] == '0' ? @opcodes[command[1]] : command[1]
    b = padded[1] == '0' ? @opcodes[command[2]] : command[2]
  
    return a, b, command[3]
  end
end
