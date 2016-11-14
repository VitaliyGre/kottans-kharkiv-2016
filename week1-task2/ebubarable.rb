module Ebuberable

  def map
    return self.each unless block_given?
    result = []
    self.each { |e| result << yield(e) }
    result
  end

  def select
    result = []
    self.each { |e| result << e if yield(e) }
    result
  end

  def reject
    result = []
    self.each { |e| result << e unless yield(e) }
    result
  end

  def grep(p)
    result = []
    self.each do |e|
      next unless p === e
      e = yield(e) if block_given?
      result << e
    end
    result
  end

  def all?(&block)
    block ||= :itself.to_proc
    self.each { |e| return false unless block.call(e) }
    true
  end

  def reduce(*p, &block)
    if p[0].is_a?(Symbol)
      op = p[0]
    else
      initial, op = p
    end

    block ||= op.to_proc
    self.each { |e| initial = initial ? block.call(initial, e) : e }

    initial
  end

end

