Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :slack, Rails.application.config.credentials.dig(:slack, :api_key), Rails.application.config.credentials.dig(:slack, :api_secret),{
  #   scope: 'identify',
  #   :provider_ignores_state => true
  # }

  provider :slack, '2694475882850.2707181232417', 'a8f6374435f3f96f6efe4bac5f216c89', {
    scope: 'identify',
    :provider_ignores_state => true
  }

end