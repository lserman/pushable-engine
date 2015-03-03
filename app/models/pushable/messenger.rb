module Pushable
  class Messenger < ActiveJob::Base

    def perform(device_ids, payload)
      send_gcm  Device.android.where(id: device_ids).pluck(:token), payload
      send_apns Device.ios.where(id: device_ids).pluck(:token), payload
    end

    def send_gcm(tokens, payload)
      return unless tokens.any?
      service = GCM::Service.new
      notification = GCM::Notification.new(payload)
      service.deliver notification, tokens
    end

    def send_apns(tokens, payload)
      return unless tokens.any?
      service = APNS::Service.new
      notification = APNS::Notification.new(payload)
      service.deliver notification, tokens
    end

  end
end
