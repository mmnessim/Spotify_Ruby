require 'sinatra/base'
require 'json'
require_relative 'lib/spotify_oauth'
require_relative 'lib/request'

def authenticate
    if request.path_info == '/login' || request.path_info == '/callback'
        return
    elsif session['access_token'] == nil
        redirect '/login'
    end
end

class Server < Sinatra::Base
include SpotifyRequests
enable :sessions, :logging

  before do
    authenticate
  end

  BASE_URL = "https://api.spotify.com/v1/" #does this need to be here???
  def initialize
      super
  end

  get '/' do
    @token = session['access_token']
    r = SpotifyRequests::Requests.new("/search", "Laufey", "artist", @token)
    #placeholder search
    @result = r.result['artists']['items']
    @title = "Spotify Search"
    #puts @result
    @page = :index
    erb :"templates/base"

  end

  get '/login' do
    a = SpotifyRequests::Authorize.new
    @url = a.url
    @page = :login
    erb :"templates/base"
  end

  get '/callback' do
    @code = params['code']
    #puts @code
    a = SpotifyRequests::Client.new(@code)
    @token = a.token
    session['access_token'] = @token
    redirect '/'
  end

end

Server.run!
