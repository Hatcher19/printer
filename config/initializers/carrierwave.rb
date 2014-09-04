CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAI5RDQCT3ACLQ2ZLA',       # required
    :aws_secret_access_key  => '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'                        # required
  }
  config.fog_directory  = 'shirtclerk'                    # required
  config.fog_public     = false                              # optional, defaults to true
end