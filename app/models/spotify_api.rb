class SpotifyApi
  attr_accessor :token, :response, :client

  def initialize
    connect
  end

  def connect
    client_id = Rails.configuration.spotify["client_id"]
    client_secret = Rails.configuration.spotify["client_secret"]
    grant = Base64.encode64("#{client_id}:#{client_secret}").delete("\n")

    response = RestClient.post('https://accounts.spotify.com/api/token',
                               {'grant_type' => 'client_credentials'},
                               {"Authorization" => "Basic #{grant}"})
    self.response = JSON.parse(response.body)
    self.token = self.response["access_token"]
    config = {
      :access_token =>  self.response["access_token"],  # initialize the client with an access token to perform authenticated calls
      :raise_errors => true,  # choose between returning false or raising a proper exception when API calls fails

      # Connection properties
      :retries       => 0,    # automatically retry a certain number of times before returning
      :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
      :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
      :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
    }
    self.client = Spotify::Client.new(config)
  end
end