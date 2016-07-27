require 'date'
require 'byebug'

class Calendar
  attr_reader :month, :year, :week_starts_on

  def initialize(month, year, week_starts_on=0)
    @month = month
    @year = year
    @week_starts_on = week_starts_on
    @first_date = Date.new(@year, @month, 1)
    @last_date = Date.new(@year, @month, -1)
  end

  def day_names
    0.upto(6).map { |wday| day_name(wday + @week_starts_on) }
  end

  def weeks
    padding = [@first_date.wday - @week_starts_on, 0].max
    days = Array.new(padding) + (@first_date.day..@last_date.day).to_a
    @weeks = days.each_slice(7).to_a
  end

  def month_name
    month_names = %w(January February March April May June July August September October November December)
    month_names[@month - 1]
  end

  private

  def day_name(i)
    %w(Su Mo Tu We Th Fr Sa)[i % 7]
  end
end


class CalendarStringRenderer
  def initialize(calendar)
    @calendar = calendar
  end

  def render
    lines.join("\n") + "\n"
  end

  private

  def lines
    [month_name, day_names, weeks]
  end

  def weeks
    @calendar.weeks.map {|w| week_str(w)}.join "\n"
  end

  def week_str(week)
    week.map {|d| day_str(d) }.join " "
  end

  def day_str(day)
    day.to_s.rjust(2)
  end

  def day_names
    @calendar.day_names.join(' ')
  end

  def month_name
    @calendar.month_name
  end
end
