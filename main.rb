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
    r = SpotifyRequests::Requests.new("/search", "Laufey", "artist", @token) #placeholder search
    @result = r.result['artists']['items']
    @title = "Spotify Search"
    #puts @result
    @page = :index
    erb :"templates/base"
  end

end

Server.run!
