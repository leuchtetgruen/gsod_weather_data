require 'json'
require 'pry'
require 'date'

class Array
  def sum
    self.inject(0){|sum,x| sum + x }
  end

  def avg
    return self.sum.to_f / self.size.to_f
  end

  def pick_datum(key)
    return self.map { |h| h[key] }
  end

  def sanitize_temperatures(min=-60,max=60)
    self.select { |t| (min < t) && (t < max)}
  end

  def sanitize_prcp(filter_value=2539.7)
    self.select { |p| p != filter_value }
  end
end

if ARGV.size < 1
  puts "ruby analyse_weather.rb FILENAME"
  exit
end

FILENAME = ARGV[0]
WEATHER_DATA = JSON.parse(File.read(FILENAME)).map { |ok,ov| [ok, ov.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}]}.to_h

def weather_for_day(day)
  WEATHER_DATA[day.to_s] 
end

def all_data_for(years=nil, months=nil, days=nil)
  days = WEATHER_DATA.keys.select do |date|
    d = Date.parse(date)
    ((years.nil? || years.include?(d.year)) &&
     (months.nil? || months.include?(d.month)) &&
     (days.nil? || days.include?(d.day))
    )
  end
  days.map { |d| WEATHER_DATA[d] }
end

def decades_between(from,to)
  s0 = from - (from % 10)
  se = to - (to % 10)
  (s0..se).step(10).map { |start| (start..start+9)}
end


puts "use weather_for_day(YYYY-MM-DD / Date) to find weather for a particular day"
puts "use all_data_for(years=nil, months=nil, days=nil) to find all data for a specific timeframe"
puts "use decades_between(start_year, end_year)"
puts "use Array.sum, Array.avg"
puts "use Array.pick_datum(key) to pick a certain datum from an array of hashes"
puts "use Array.sanitize_temperatures and Array.sanitize_prcp"
binding.pry
