class Wombat
  MEALS = %w[grasses sedges herbs bark roots]

  def home
    'Australia'
  end

  def length
    100
  end

  def weight
    45
  end

  def marsupial?
    true
  end

  def run
    true
  end

  def eat(meal)
    MEALS.include? meal
  end
end

class Burrow
  attr_accessor :wombat

  def initialize(wombat)
    @wombat = wombat
  end
end