require 'httparty'
require 'json'
require 'dotenv/load'

module OAuth

    def get_access_token
        @client = Client.new
        #puts @client.token
        @client.token
    end

    class Authorize
    include HTTParty
        attr_accessor :token

        def initialize()
            env = Dotenv.parse('.env')
            @client_id = env['CLIENT_ID']
            @client_secret = env['CLIENT_SECRET']
            @redirect_uri = env['REDIRECT_URL']
            @url = "https://accounts.spotify.com/authorize?" + "client_id=" + @client_id + "&response_type=code&redirect_uri=" + @redirect_uri
            res = HTTParty.get(@url)
            @result = JSON.parse(res.body)
            #puts @result
        end
    end

    class Client
        include HTTParty
        attr_accessor :token

        def initialize()
            env = Dotenv.parse('.env')
            @client_id = env['CLIENT_ID']
            @client_secret = env['CLIENT_SECRET']
            @redirect_uri = env['REDIRECT_URL']
            #puts env

            res = HTTParty.post("https://accounts.spotify.com/api/token", :body => {grant_type:'client_credentials', client_id: @client_id, client_secret: @client_secret, redirect_uri: @redirect_url})

            @token = res['access_token']
            #puts res
        end
    end
end

#include OAuth

#a = Authorize.new

