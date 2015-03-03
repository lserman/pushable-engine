module Pushable
  class Messenger < ActiveJob::Base

    def perform(device_ids, payload)
      send_gcm  Device.android.where(id: device_ids).pluck(:token), payload
      send_apns Device.ios.where(id: device_ids).pluck(:token), payload
    end

    def send_gcm(tokens, payload)
      return unless tokens.any?
      Rails.logger.info "[GCM] Sending to #{tokens.size} tokens..."
      Rails.logger.info "[GCM] Payload: #{payload}"
      service = GCM::Service.new
      notification = GCM::Notification.new(payload)
      result = service.deliver notification, tokens
      result.responses.each do |resp|
        Rails.logger.info "[GCM] Response: #{resp.message}"
      end
    end

    def send_apns(tokens, payload)
      return unless tokens.any?
      Rails.logger.info "[APNS] Sending to #{tokens.size} tokens..."
      Rails.logger.info "[APNS] Payload: #{payload}"
      service = APNS::Service.new
      notification = APNS::Notification.new(payload)
      service.deliver notification, tokens
    end

  end
end
