require 'rest-client'
require 'json'
require 'pry'

def get_api
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
end

def get_character_hash(character_name)
  get_api["results"].find do |info|
    info["name"].downcase == character_name.downcase
  end["films"]
end

def get_character_movies_from_api(character_name)
  #make the web request
  # response_string = RestClient.get('http://www.swapi.co/api/people/')
  # response_hash = JSON.parse(response_string)
  # # binding.pry
  # get_api
  # character_hash = get_api["results"].find do |info|
  #   info["name"].downcase == character_name.downcase
  #   # binding.pry
  # end
    # binding.pry
  # film_list = character_hash["films"]

  # info["films"]
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  get_character_hash(character_name).map do |url|
    JSON.parse(RestClient.get(url))
  end
  # binding.pry
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end
# get_character_movies_from_api("C-3PO")
# binding.pry

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts film['title']
  end
# binding.pry
end
# print_movies(get_character_movies_from_api("C-3PO"))


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end
# show_character_movies('C-3po')
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
