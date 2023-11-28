require 'sinatra/base'
require 'json'
require_relative 'lib/spotify_oauth'
require_relative 'lib/request'

class Server < Sinatra::Base
include SpotifyRequests

  BASE_URL = "https://api.spotify.com/v1/"
  def initialize
      super
      @token = get_access_token
  end

  get '/' do
    r = SpotifyRequests::Requests.new("/search", "Laufey", "artist", @token)
    @result = r.result
    JSON.pretty_generate(@result)
  end

end

Server.run!
