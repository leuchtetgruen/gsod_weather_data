require 'date'
require 'json'

I_YEAR = [14,17]
I_MONTH = [18,19]
I_DAY = [20,21]
I_TEMP = [24,29]
I_MIN = [110,116]
I_MAX = [102,107]
I_PRCP = [118,122]

if ARGV.size < 3
  puts "ruby import_from_gsod.rb STATION_ID START_YEAR END_YEAR"
  exit
end

STATION_ID = ARGV[0]
WBAN_ID = 99999
YEARS = (ARGV[1].to_i..ARGV[2].to_i).to_a

class String
  def sub(indexSet)
    self[indexSet[0]..indexSet[1]]
  end
end

class Float
  def to_celsius
    return (self - 32.0) / (9.0/5.0)
  end

  def to_mm
    return self * 25.4
  end
end


def line_to_dataset(line)

  year = line.sub(I_YEAR).to_i
  month = line.sub(I_MONTH).to_i
  day = line.sub(I_DAY).to_i
  date = Date.new(year, month, day)

  min = line.sub(I_MIN).to_f.to_celsius.round(1)
  max = line.sub(I_MAX).to_f.to_celsius.round(1)
  temp = line.sub(I_TEMP).to_f.to_celsius.round(1)
  prcp = line.sub(I_PRCP).to_f.to_mm.round(1)

  [date.to_s, {
    min: min,
    max: max,
    temp: temp,
    prcp: prcp
  }]
end

def read_op_file(filename)
  lines = File.read(filename).split("\n")[1..-1]
  lines.map { |l| line_to_dataset(l) }.to_h
end

final_filename = "weather-#{STATION_ID}.json"
all_hash = if File.exist?(final_filename)
             JSON.parse(File.read(final_filename))
           else
             {}
           end

YEARS.each do |year|
  puts "Parsing #{year}..."
  filename = "#{STATION_ID}-#{WBAN_ID}-#{year}.op"
  if File.exist?(filename)
    year_hash = read_op_file(filename)
    all_hash = all_hash.merge(year_hash)
  else
    puts "! No data for this year"
  end
end

puts "Writing DB..."
File.write(final_filename,all_hash.to_json)
