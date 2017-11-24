Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1445472255537762', 'f4db4ad35daad5f0253e0880f510d64c', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
