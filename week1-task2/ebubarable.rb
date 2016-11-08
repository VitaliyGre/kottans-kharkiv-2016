module Ebuberable

  def map(&block)
    block ||= :itself.to_proc
    result = []
    self.each { |e| result << block.call(e) }
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

  def reduce1(*p)
    if Symbol === p[0]
      op = p[0]
    else
      initial = p[0]
      op = p[1]
    end

    self.each do |e|
      if initial
        initial = op ? e.send(op, initial) : yield(initial, e)
      else
        initial = e
      end
    end
    initial
  end

end

