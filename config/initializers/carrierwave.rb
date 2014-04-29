CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIQQNZZTZJ4DRUCYA',       # required
    :aws_secret_access_key  => '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',                        # required
  }
  config.fog_directory  = 'AWS_S3_BUCKET'                    # required
  config.fog_public     = false                              # optional, defaults to true
end