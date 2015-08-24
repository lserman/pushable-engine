module Pushable
  class Messenger < ActiveJob::Base

    def perform(device_ids, payload)
      tokens = Device.where(id: device_ids).pluck :token
      push payload, to: tokens
    end

    def push(payload, to: [])
      return if to.empty?
      Rails.logger.info "[GCM] Sending to #{to.size} tokens..."
      Rails.logger.info "[GCM] Payload: #{payload}"

      notification = GCM::Notification.new payload
      result = gcm.deliver notification, to
      result.responses.each do |resp|
        Rails.logger.info "[GCM] Response: #{resp.message}"
      end
    end

    private
      def gcm
        @_gcm ||= GCM::Service.new
      end
  end
end
