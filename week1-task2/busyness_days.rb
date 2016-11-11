require 'date'
require 'holidays'

class BusynessDays < Enumerator.Lazy
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
      if date.wday != 6 && date.wday != 0 && Holidays.on(date, @locale).empty?
        block.call(date)
      end
    end
  end
end
