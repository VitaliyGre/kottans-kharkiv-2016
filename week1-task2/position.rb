class Position
  attr_accessor :hash

  def initialize(hash)
    @hash = hash
  end

  def to_proc
    Proc.new do |e|
      r = @hash[e]
      r ? [e, r] : [e, :empty]
    end
  end

  def occupied(piece = nil)
    Proc.new do |e|
      if piece
        @hash[e].to_s.include? piece.to_s
      else
        @hash[e] != nil
      end

    end
  end
end