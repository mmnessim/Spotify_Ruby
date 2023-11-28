require 'httparty'
require 'json'
require_relative 'spotify_oauth'

module SpotifyRequests
include OAuth

  class Requests
    attr_accessor :token, :result
    BASE_URL = 'https://api.spotify.com/v1'

    def initialize(path, query, type, token)
      @token = token
      @path = path
      @query = query
      @uri = BASE_URL + path + '?q=' + query + '&type=' + type
      res = HTTParty.get(@uri, { :headers => { 'Authorization' => "Bearer #{@token}"}})
      @result = JSON.parse(res.body)
      #puts @result

    end

  end

end

