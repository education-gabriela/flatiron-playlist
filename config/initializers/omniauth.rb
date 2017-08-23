Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '309392679469293', 'bed014be21c23d1acac14651c94caf36', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
