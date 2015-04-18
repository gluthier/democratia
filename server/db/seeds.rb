# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def generate_political_parties
  connection = ActiveRecord::Base.connection();
  File.open('db/political.sql') do |file|
    file.readlines.each do |line|
      begin
        connection.execute(line)
      rescue
        puts 'An error occurred when inserting political parties data'
      end
    end
  end
end

def generate_users
  connection = ActiveRecord::Base.connection();
  File.open('db/users.sql') do |file|
    file.readlines.each do |line|
      begin
        connection.execute(line)
        puts 'Inserting user into database'
      rescue
        puts 'An error occurred when inserting user data'
      end
    end
  end
end

def  generate_cantons
  file = File.read('../data/ch-cantons.json')
  json = JSON.parse(file)
  json['objects']['cantons']['geometries'].each do |canton|
    canton = canton['properties']
    if Canton.find_by_name(canton['name']).nil?
      puts "Insert new canton #{canton['name']}-#{canton['abbr']} inside database"
      canton = Canton.create(name: canton['name'], shortname: canton['abbr'], json_id_canton: canton['id'])
      if !canton.nil?
        generate_municipalities(canton)
      end
    end
  end
end

# TODO the name are not in the json file !
def generate_districts
  file = File.read('../data/ch-districts.json')
  json = JSON.parse(file)
  json['objects']['cantons']['geometries'].each do |district|
    district = district['properties']
    if Canton.find_by_json_id_canton(district['id']).nil?
      puts "Insert new district #{district['id']} inside database"
      District.create(name: district['name'], shortname: district['abbr'], json_id_district: district['id'])
    end
  end
end

def generate_municipalities(canton)
  file = File.read("../data/#{canton.shortname.downcase}-municipalities.json")
  json = JSON.parse(file)
  json['objects']['municipalities']['geometries'].each do |municipality|
    municipality = municipality['properties']
    if Canton.find_by_name(municipality['name']).nil?
      puts "Insert new municipality #{municipality['name']} inside database"
      Municipality.create(name: municipality['name'], json_id_municipality: municipality['id'], canton_id: canton.id)
    end
  end
end

generate_political_parties
generate_users
generate_cantons
#generate_districts
