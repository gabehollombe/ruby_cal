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
    0.upto(6).map { |wday| day_name[(wday + @week_starts_on) % 7] }
  end

  def weeks
    padding = [@first_date.wday - @week_starts_on, 0].max
    days = Array.new(padding) + (@first_date.day..@last_date.day).to_a
    @weeks = days.each_slice(7).to_a
  end

  private

  def day_name
    %w(Su Mo Tu We Th Fr Sa)
  end
end


class CalendarStringRenderer
  def initialize(calendar)
    @calendar = calendar
  end

  def render
    lines.join("\n")
  end

  private

  def lines
    buffer = []
    buffer << month_name
    buffer << day_names
    buffer << weeks + "\n"
    buffer
  end

  def weeks
    week_strings = []
    @calendar.weeks.each do |week|
      week_strings << week_str(week)
    end
    week_strings.join("\n")
  end

  def week_str(week)
    day_strs = []
    week.each do |day|
      day_str = single_digit_day?(day) ? "#{day} " : day.to_s
      day_strs << day_str(day)
    end
    day_strs.join(' ')
  end

  def day_str(day)
    return "  " if day.nil?
    return " #{day}" if day.to_s.length == 1
    return day.to_s
  end

  def single_digit_day?(day)
    day.to_s.length == 1 || day.nil?
  end

  def day_names
    @calendar.day_names.join(' ')
  end

  def month_name
    month_names = %w(January February March April May June July August September October November December)
    month_names[@calendar.month - 1]
  end
end
