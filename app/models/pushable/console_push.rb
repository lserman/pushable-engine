module Pushable
  class ConsolePush
    include ActiveModel::Model

    attr_accessor :device_token, :klass, :data, :sent_count

    validates :klass, :device_token, presence: true

    def initialize(attributes = {})
      super
      @sent_count = 0
    end

    def deliver
      data.each do |name, info|
        setter = "#{name}="
        if message.respond_to?(setter)
          value = info['value']
          value = value.to_i if info['type'] == 'integer'
          message.send setter, value
        end
      end

      devices.each do |device|
        if recipient = device.pushable
          response = message.send_to recipient
          self.sent_count += 1
        end
      end
    end

    private

      def devices
        @_devices ||= Pushable::Device.where(token: device_token)
      end

      def message
        @_message ||= begin
          _class = Class.new(klass.constantize) do
            def initialize
            end
          end

          _class.new
        end
      end

  end
end
