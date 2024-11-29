# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Liste des films
require 'open-uri'
require 'json'
Movie.destroy_all+

Movie.find_or_create_by!(title: 'Wonder Woman 1984') do |movie|
  movie.overview = 'Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s'
  movie.poster_url = 'https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg'
  movie.rating = 6.9
end

Movie.find_or_create_by!(title: 'The Shawshank Redemption') do |movie|
  movie.overview = 'Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison'
  movie.poster_url = 'https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg'
  movie.rating = 8.7
end

Movie.find_or_create_by!(title: 'Titanic') do |movie|
  movie.overview = '101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.'
  movie.poster_url = 'https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg'
  movie.rating = 7.9
end

Movie.find_or_create_by!(title: 'Ocean\'s Eight') do |movie|
  movie.overview = 'Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.'
  movie.poster_url = 'https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg'
  movie.rating = 7.0
end

# Récupérer les films via l'API
url = 'https://tmdb.lewagon.com/movie/top_rated'
response = URI.open(url).read
movies_data = JSON.parse(response)['results']
# Ajouter les films à la base de données
movies_data.each do |movie_data|
  Movie.create(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}",
    rating: movie_data['vote_average']
  )
end
