require 'httparty'
require 'json'
require_relative 'spotify_oauth'

module SpotifyRequests
include OAuth

  def get_access_token
    @client = Client.new
    puts @client.token
    @client.token
  end

  class Requests
    attr_accessor :token, :result
    BASE_URL = 'https://api.spotify.com/v1'

    def initialize(path, query, type)
      @token = get_access_token
      @path = path
      @query = query
      @uri = BASE_URL + path + '?q=' + query + '&type=' + type
      res = HTTParty.get(@uri, { :headers => { 'Authorization' => "Bearer #{@token}"}})
      @result = JSON.parse(res.body)
      puts @result

    end

  end

end

include SpotifyRequests
r = SpotifyRequests::Requests.new('/search', 'Laufey', 'artist')
puts r.token
