require 'rest-client'
require 'json'
require 'pry'

def get_api
  #accessing api and coverting them to JSON
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
end


def get_film_list_hash(character_name)
  #iterates through get_api, checks if argument = name/ returns film url collection
  get_api["results"].find do |info|
    info["name"].downcase == character_name.downcase
  end["films"]
end


def get_character_movies_from_api(character_name)
  #gets character film info as an array of URLs
  get_film_list_hash(character_name).map do |url|
    JSON.parse(RestClient.get(url))
  end
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  #prints movie titles
  films.each do |film|
    puts film['title']
  end
end


def show_character_movies(character)
  #run file / used to print out final results from above methods
  films = get_character_movies_from_api(character)
  print_movies(films)
end
