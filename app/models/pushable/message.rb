module Pushable
  class Message
    MAX_TOKENS_AT_ONCE = 999

    def send_to(pushable)
      each_slice_of_device_tokens_in(pushable.devices) do |tokens|
         Pushable::Messenger.perform_later tokens, to_h.deep_stringify_keys
      end
    end

    def alert
      ''
    end

    def badge
      1
    end

    def sound
      'default'
    end

    def data
      {}
    end

    def content_available?
      nil
    end

    def to_h
      {
        data: data,
        notification: {
          body: alert,
          sound: sound,
          badge: badge.to_s
        },
        content_available: content_available?,
      }
    end

    private
      def each_slice_of_device_tokens_in(devices)
        devices.pluck(:id).each_slice MAX_TOKENS_AT_ONCE do |tokens|
          yield tokens
        end
      end
  end
end
