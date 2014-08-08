# cal = Calendar.new
#
# puts cal.week_day_names.join(' ')
# cal.weeks.each do |week|
#   puts_week cal.week
# end
#
# def puts_week(week)
#   puts week.days.join(' ')
# end

require 'date'

require 'byebug'

class Calendar
  attr_reader :month, :year, :weeks

  def initialize(month, year)
    @month = month
    @year = year
    @first_date = Date.new(@year, @month, 1)
    @last_date = Date.new(@year, @month, -1)

    build_weeks
  end

  def day_names
    %w(Su Mo Tu We Th Fr Sa)
  end

  private

  def build_weeks
    first_date_wday = @first_date.wday
    last_date_wday = @last_date.wday

    @weeks = []
    week = [nil, nil, nil, nil, nil, nil, nil]
    days = @first_date.day..@last_date.day
    days.each do |cur_day|
      cur_date = Date.new(@year, @month, cur_day)
      week[cur_date.wday] = cur_day

      if is_end_of_week(cur_date) || is_end_of_month(cur_date)
        @weeks << week
        week = Array.new(7)
      end
    end
  end

  def is_end_of_week(date)
    date.wday == 6
  end

  def is_end_of_month(date)
    date.day == @last_date.day
  end
end
