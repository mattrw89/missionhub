require 'moonshado-mass'
SMS = Moonshadosms::Sender.new(APP_CONFIG['sms_short_code'], APP_CONFIG['sms_api_key'], APP_CONFIG['sms_default_keyword'])
SMS.logger = Rails.logger
