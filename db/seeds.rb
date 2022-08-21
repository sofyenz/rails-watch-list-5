# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "json"

puts "Cleaning up database..."
Movie.destroy_all
# This deletes all data in the moview table of db. If you don't want, just comment it.
puts "Database cleaned"

base_url = "http://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(base_url).read # we can then read in this JSON. We access all the movies list.
movies = JSON.parse(movies_serialized) # With JSON.parse() we transform the JSON into a Ruby object: a hash.

# Good to print each step to see which object/structure we have. Do it with Terminal / ruby and select seeds.rb file.
# CHECK: puts movies["results"][0]["original_title"]
# Then the real db:seed will be done from Terminal / rails db:seeds command
# movies_serialized is a JSON, movies is a hash. Its results key movies["results"] has a value in a form of an array, each item of this array is a movie presented as hash.
movies_top20 = movies["results"].first(20) # Take the 1st 20 movies in the results array
movies_top20.each do |movie|
  Movie.create(
    title: movie["original_title"],
    overview: movie["overview"],
    rating: movie["vote_average"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["backdrop_path"]}]"
  )
  puts "Created #{movie['title']}"
  # no need to do a save to db because Movie.create, create also saves. Not like Movie.new which needs a save! afterwards.
end
# Go in rails console, (irb), check Movie.count => displays number of movies in db (by calling the count method on the Movie model which has a corresponding table in db ActiveRecord/Postgres.
