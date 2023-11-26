require 'httparty'
require 'json'
require 'dotenv/load'

module OAuth

    class Client
        include HTTParty
        attr_accessor :token

        def initialize()
            env = Dotenv.parse('.env')
            @client_id = env['CLIENT_ID']
            @client_secret = env['CLIENT_SECRET']
            @redirect_uri = env['REDIRECT_URL']
            puts env

            res = HTTParty.post("https://accounts.spotify.com/api/token", :body => {grant_type:'client_credentials', client_id: @client_id, client_secret: @client_secret, redirect_uri: @redirect_url})

            @token = res['access_token']
            puts res
        end
    end
end

include OAuth

r = Client.new

puts r.token

