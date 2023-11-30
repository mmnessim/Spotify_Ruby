require 'sinatra/base'
require 'json'
require_relative 'lib/spotify_oauth'
require_relative 'lib/request'

class Server < Sinatra::Base
include SpotifyRequests
enable :sessions, :logging

  BASE_URL = "https://api.spotify.com/v1/" #does this need to be here???
  def initialize
      super
  end

  get '/' do
    if session['access_token'] == nil
      "not logged in"
    else
      @token = session['access_token']
      r = SpotifyRequests::Requests.new("/search", "Laufey", "artist", @token)
      #placeholder search
      @result = r.result['artists']['items']
      @title = "Spotify Search"
      #puts @result
      @page = :index
      erb :"templates/base"
    end
  end

  get '/login' do
    a = SpotifyRequests::Authorize.new
    redirect a.url
  end

  get '/callback' do
    @code = params['code']
    puts @code
    a = SpotifyRequests::Client.new(@code)
    @token = a.token
    session['access_token'] = @token
    redirect '/'
  end

end

Server.run!
