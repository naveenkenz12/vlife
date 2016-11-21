require 'resolv-replace'
CarrierWave.configure do |config|
  config.fog_credentials = {
  	  :provider				=> 'AWS',
      :host           => ENV["ASSET_HOST"],
      :port           => ENV["ASSET_PORT"].to_i,
      :scheme               => 'http',
      :aws_access_key_id      => "TICN3MI355BLA9FZDYCY",
      :aws_secret_access_key  => "K3ydjJYHjVbRws5PnbVtwsa25tpBDFw_iNWJ6w==",
      
  }
  config.fog_public = true
  config.asset_host = "http://"+ENV["ASSET_HOST"]+':'+ ENV["ASSET_PORT"]
  config.fog_use_ssl_for_aws = false
  config.storage             = :fog
end