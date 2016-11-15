require 'date'
require 'holidays'

class BusynessDays
  include Enumerable

  def initialize(start_date = Date.today, locale = :us)
    @start_date = start_date
    @locale = locale
  end

  #
  # Use only with lazy
  #
  def each(&block)
    (0..Float::INFINITY).each do |e|
      date = @start_date + e
      unless weekend?(date) || holiday?(date)
        block.call(date)
      end
    end
  end

  def weekend?(date)
    date.wday == 6 || date.wday == 0
  end

  def holiday?(date)
    Holidays.on(date, @locale).any?
  end
end
