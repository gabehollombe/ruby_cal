#     August 2014
# Su Mo Tu We Th Fr Sa
#                 1  2
#  3  4  5  6  7  8  9
# 10 11 12 13 14 15 16
# 17 18 19 20 21 22 23
# 24 25 26 27 28 29 30
# 31

require 'rspec'
require_relative './calendar'

describe 'calendar' do
  let(:cal) { Calendar.new(1, 1970) }

  it 'inits a month and year' do
    expect(cal.month).to eq 1
    expect(cal.year).to eq 1970
  end

  it 'has day names' do
    expect(cal.day_names).to eq %w(Su Mo Tu We Th Fr Sa)
  end

  it 'has weeks, an array of week arrays' do
    expect(cal.weeks).to be_kind_of Array
    expect(cal.weeks.first).to be_kind_of Array
  end

  it 'has day integers for days in each week' do
    expect(cal.weeks.first.last).to be_kind_of Fixnum
  end

  it "puts nil in each index of the first week that don't have a day" do
    cal = Calendar.new(8, 2014)
    expect(cal.weeks.first.first).to be_nil
  end

  context 'August 2014' do
    let(:cal) { Calendar.new(9, 2014) }

    it 'has 5 weeks' do
      expect(cal.weeks.length).to eq 5
    end
  end

  context 'March 2014' do
    let(:cal) { Calendar.new(3, 2014) }

    it 'has 6 weeks' do
      expect(cal.weeks.length).to eq 6
    end
  end

  context 'Feb 2015' do
    let(:cal) { Calendar.new(2, 2015) }

    it 'has 4 weeks' do
      expect(cal.weeks.length).to eq 4
    end
  end
end
