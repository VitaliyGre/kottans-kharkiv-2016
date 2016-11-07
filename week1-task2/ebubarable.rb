module Ebuberable

  def map
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
      if p === e
        if block_given?
          e = yield(e)
        end
        result << e
      end
    end
    result
  end

  def all?(&block)
    block = lambda {|obj| obj} unless block_given?
    self.each { |e| return false unless block.call(e) }
    true
  end

  def reduce(initial = nil)
    self.each do |e|
      if initial
        initial = yield(initial, e)
      else
        initial = e
      end
    end
    initial
  end

end

