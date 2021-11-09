Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['2694475882850.2707181232417'], ENV['a8f6374435f3f96f6efe4bac5f216c89'], scope: 'team:read,users:read,identify'
  # provider :slack, ENV['2694475882850.2707181232417'], ENV['a8f6374435f3f96f6efe4bac5f216c89'], scope: 'identity.basic', name: :sign_in_with_slack, team: "foo"
  # provider :slack, ENV['SLACK_APP_ID'], ENV['SLACK_APP_SECRET'], scope: 'dnd:read,dnd:write', team: "foo"

end