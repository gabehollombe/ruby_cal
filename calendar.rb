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
    'Su Mo Tu We Th Fr Sa'
  end

  def month_name
    month_names = {
      1 => 'January',
      2 => 'February',
      3 => 'March',
      4 => 'April',
      5 => 'May',
      6 => 'June',
      7 => 'July',
      8 => 'August',
      9 => 'September',
      10 => 'October',
      11 => 'November',
      12 => 'December' }
    month_names[@calendar.month]
  end
end
