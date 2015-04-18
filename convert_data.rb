require 'json'

file = File.read('data/ch.json')
data = JSON.parse(file)

data['objects']['municipalities']['geometries'].each do |muni|
  muni['properties']['type'] = 'municipality'
end

data['objects']['cantons']['geometries'].each do |canton|
  canton['properties']['type'] = 'canton'
end

data['objects']['districts']['geometries'].each do |canton|
  canton['properties']['type'] = 'district'
end

File.write('data/ch-2.json', data.to_json)
