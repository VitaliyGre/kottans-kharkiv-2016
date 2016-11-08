class Position
  attr_accessor :hash_of_pieces

  def initialize(hash)
    @hash_of_pieces = hash
  end

  def to_proc
    Proc.new do |e|
      r = @hash_of_pieces[e] || :empty
      [e, r]
    end
  end

  def occupied(piece = nil)
    if piece
      piece = piece.to_s
      Proc.new do |e|
        @hash_of_pieces[e].to_s.include? piece
      end
    else
      Proc.new do |e|
        @hash_of_pieces.key?(e)
      end
    end
  end
end