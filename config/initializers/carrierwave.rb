require 'resolv-replace'
CarrierWave.configure do |config|
  config.fog_credentials = {
  	  :provider				=> 'AWS',
      :aws_access_key_id      => "TICN3MI355BLA9FZDYCY",
      :aws_secret_access_key  => "K3ydjJYHjVbRws5PnbVtwsa25tpBDFw_iNWJ6w==",
      :host           => "127.0.0.1",
      :port           => 8080,
      :persistent             => false,
      :scheme               => 'http',
      :endpoint             => 'http:127.0.0.1:8080',

      :connection_options => {
          :proxy => 'http://127.0.0.1:8080',
      }
  }
  config.fog_public = true
  config.asset_host = 'http://127.0.0.1:8080'
  config.fog_use_ssl_for_aws = false
  config.storage             = :fog
end