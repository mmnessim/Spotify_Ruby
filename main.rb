require 'sinatra/base'
require 'json'
require_relative 'lib/spotify_oauth'
require_relative 'lib/request'

class Server < Sinatra::Base
include SpotifyRequests
enable :sessions, :logging

  BASE_URL = "https://api.spotify.com/v1/"
  def initialize
      super
      @token = get_access_token
  end

  get '/' do
    session['code'] = params['code']
    puts session['code']
    r = SpotifyRequests::Requests.new("/search", "Laufey", "artist", @token)
    #placeholder search
    @result = r.result['artists']['items']
    @title = "Spotify Search"
    puts @result
    @page = :index
    erb :"templates/base"
  end

  get '/login' do
    #current redirects to '/', but needs to redirect to another endpoint to get the token after using the code, THEN it can go to '/'
    a = SpotifyRequests::Authorize.new
    redirect a.url
  end

end

Server.run!
