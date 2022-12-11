class Monkey
  attr_reader :inspected_items, :items, :test

  @@lcm = 0

  def initialize(desc, worry_descrease: true)
    split_desc(desc)
    @inspected_items = 0
    @worry_descrease = worry_descrease
  end

  def add_item(item)
    @items.push(item)
  end

  def process_items
    processed_items = @items.map { |item| process_item(item) }
    @items = []
    processed_items
  end

  def <=>(other)
    @inspected_items <=> other.inspected_items
  end

  def *(other)
    @inspected_items * other.inspected_items
  end

  private

  def split_desc(desc)
    _, st, op, te, tr, fa = desc.split("\n")

    @items = st.split(': ')[1].split(', ').map(&:to_i)
    @operation = op.split('= ')[1]
    @test = te.split('by ')[1].to_i
    @true = tr.split('monkey ')[1].to_i
    @false = fa.split('monkey ')[1].to_i
  end

  def process_item(old_item)
    old = old_item
    item = eval(@operation)
    if @worry_descrease
      item /= 3
    else
      item %= @@lcm
    end

    target = item % @test == 0 ? @true : @false

    @inspected_items += 1

    { target: target, item: item }
  end
end
