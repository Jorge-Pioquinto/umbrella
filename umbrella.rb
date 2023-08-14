require "http"
require "json"

pp "Where are you located?"

user_location = gets.chomp.gsub(" ", "%20")

pp user_location

pp "Checking the weather at Brooklyn...."

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"

resp = HTTP.get(maps_url)

raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

pp "Your coordinates are #{latitude}, #{longitude}."



pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"

raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

pp "It is currently #{current_temp.to_s}°F."
