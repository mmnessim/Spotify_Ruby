require 'sinatra/base'
require 'json'
require_relative 'lib/spotify_oauth'

class Server < Sinatra::Base
include OAuth

  BASE_URL = "https://api.spotify.com/v1/"
  def initialize
      @token = client.token
      puts @token
  end

  get '/' do
    "Hello"
  end

end

Server.run!
