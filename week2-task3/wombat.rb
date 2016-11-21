require 'date'
class Wombat
  MEALS = %w[grasses sedges herbs bark roots]

  def initialize
    @meal_date = Date.new(0)
  end

  def home
    'Australia'
  end

  def length
    110
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

  def eat(meal, date = Date.today)
    @meal_date = date if MEALS.include? meal
  end

  def hungry?
    Date.today > @meal_date + 14
  end

end

class Burrow
  attr_accessor :wombat

  def initialize(wombat)
    @wombat = wombat
  end
end