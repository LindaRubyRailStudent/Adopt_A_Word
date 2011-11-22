require 'omniauth/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'oK9Qv5IPAe1qiR9bkKxZbw', 'RNxEtuFbTG9wwXClGDMSw42qMnKeAZUEvoRfYMqw'
 # provider :facebook,'125271034249407', '9a89e511323f1d96b33703541254c54d', ,{ :client_options => {:ssl => {:ca_file => '/etc/pki/tls/certs/ca-bundle.crt'}}}
  provider :facebook,'125271034249407', '9a89e511323f1d96b33703541254c54d', {:ssl => {:ca_path => '/etc/ssl/certs' }, :scope => 'publish_stream,email'}

end
