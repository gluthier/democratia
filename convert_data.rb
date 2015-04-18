require 'json'

cantons = File.read('server/public/data/ch-cantons-lakes.json')
cantons = JSON.parse(cantons)

cantons['objects']['cantons']['geometries'].each do |canton|
  canton['properties']['type'] = 'canton'
end

File.write('server/public/data/ch-cantons-lakes.json', cantons.to_json)

#municipalities = File.read('data/ch-cantons-lakes.json')
#cantons = JSON.parse(cantons)

#data['objects']['municipalities']['geometries'].each do |muni|
#  muni['properties']['type'] = 'municipality'
#end

districts = File.read('server/public/data/ch-districts-lakes.json')
districts = JSON.parse(districts)

districts['objects']['districts']['geometries'].each do |canton|
  districts['properties'] = Hash.new
  districts['properties']['type'] = 'district'
end

File.write('server/public/data/ch-districts-lakes.json', districts.to_json)
