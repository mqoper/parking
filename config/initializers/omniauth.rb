Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, Rails.application.config.credentials.dig(:slack, :api_key), Rails.application.config.credentials.dig(:slack, :api_secret),{
    scope: 'identify',
    :provider_ignores_state => true
  }
end