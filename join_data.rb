require 'json'

if ARGV.size < 2
  puts "ruby join_data.rb FILE1 FILE2 ..."
  exit
end

hash = {}
ARGV.each do |filename|
  h = JSON.parse(File.read(filename))
  hash = hash.merge(h)
end

File.write("weather-joined.json", hash.to_json)
