if ARGV.size < 3
  puts "ruby download_weather.rb STATION_ID START_YEAR END_YEAR"
  exit
end


STATION_ID = ARGV[0]
WBAN_ID = 99999
YEARS = (ARGV[1].to_i..ARGV[2].to_i).to_a

YEARS.each do |year|
  puts "Downloading #{year}..."
  cmd_ftp = "wget ftp://ftp.ncdc.noaa.gov/pub/data/gsod/#{year}/#{STATION_ID}-#{WBAN_ID}-#{year}.op.gz"
  system(cmd_ftp)
  cmd_unzip = "gunzip #{STATION_ID}-#{WBAN_ID}-#{year}.op.gz"
  system(cmd_unzip)
end
