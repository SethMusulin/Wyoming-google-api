require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

class Query
  def self.initialize
    self.initialize_client
    self.initialize_big_query
  end

  def self.initialize_client
    @client = Google::APIClient.new(
        application_name: "team04-govchal00",
        application_version: "0.0.1"
    )

    #@client.key = Iwf4N6HyqNXB7go8d09Do8vD
    key = Google::APIClient::KeyUtils.load_from_pkcs12('client.p12', 'notasecret')
    @client.authorization = Signet::OAuth2::Client.new(
        :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
        :audience => 'https://accounts.google.com/o/oauth2/token',
        :scope => 'https://www.googleapis.com/auth/prediction',
        :issuer => '288137443232-mprh633v2thsj2nkquf5oko804oksp9i@developer.gserviceaccount.com',
        :signing_key => key)
    @client.authorization.fetch_access_token!
  end

  def self.initialize_big_query
    @big_query = @client.discovered_api('bigquery', 'v2')
  end

  def self.get_client
    @client
  end

  def self.get_big_query
    @big_query
  end

end