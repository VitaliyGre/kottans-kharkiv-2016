require 'date'
require 'holidays'

class BusynessDays
  include Enumerable

  def initialize(start_date = Date.today, period = 30, locale = :us)
    @start_date = start_date
    @period = period
    @locale = locale

    @holidays = Holidays.between(@start_date, @start_date + 30, @locale).map { |e| e[:date] }
  end

  def each(&block)
    block = lambda {|obj| obj} unless block_given?
    result = []
    (0...@period).each do |e|
      date = @start_date + e
      if date.wday != 6 && date.wday != 0 && !@holidays.include?(date)
        result << block.call(date)
      end
    end
    result
  end
end