require 'resolv-replace'
CarrierWave.configure do |config|
  config.fog_credentials = {
  	  :provider				=> 'AWS',
      :host           => "192.168.0.113",
      :port           => 8080,
      :scheme               => 'http',
      :aws_access_key_id      => "TICN3MI355BLA9FZDYCY",
      :aws_secret_access_key  => "K3ydjJYHjVbRws5PnbVtwsa25tpBDFw_iNWJ6w==",
      
  }
  config.fog_public = true
  config.asset_host = 'http://192.168.0.113:8080'
  config.fog_use_ssl_for_aws = false
  config.storage             = :fog
end