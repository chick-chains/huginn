module EvernoteConcern
  extend ActiveSupport::Concern

  included do
    include Oauthable
    valid_oauth_providers :evernote
    gem_dependency_check { defined?(Evernote) && Devise.omniauth_providers.include?(:evernote) }
  end

  def evernote
    @client ||= EvernoteOAuth::Client.new(token: oauth_token, consumer_key:consumer_key,
                                          consumer_secret:consumer_secret, sandbox: true)
  end

  private

  def consumer_key
    (config = Devise.omniauth_configs[:evernote]) && config.strategy.consumer_key
  end

  def consumer_secret
    (config = Devise.omniauth_configs[:evernote]) && config.strategy.consumer_secret
  end

  def oauth_token
    service && service.token
  end

end
