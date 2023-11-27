require 'sinatra/base'
require 'json'
require_relative 'lib/spotify_oauth'

class Server < Sinatra::Base
include OAuth

  BASE_URL = "https://api.spotify.com/v1/"
  def initialize
      super
      @token = get_access_token
  end

  get '/' do
    @token
  end

  get '/search' do
    "You been redirected"
  end

end

Server.run!
