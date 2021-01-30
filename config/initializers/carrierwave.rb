CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAT64OYNNNML6VD2Z2',
    aws_secret_access_key: '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',
    region:                'eu-north-1',
  }
  config.fog_directory  = 'superhi-mickey-bien-reviews'
end
