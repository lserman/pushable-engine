module Pushable
  module Controller
    extend ActiveSupport::Concern

    def create
      if @device = user_has_device_already?
        update_token_expiration
      else
        @device = create_device_token
      end
      respond_with @device
    end

    private

      def user_has_device_already?
        current_user.devices.find_by token: params[:device][:token]
      end

      def update_token_expiration
        @device.reset_token_expiry
        @device.save
      end

      def create_device_token
        current_user.devices.create permitted_params
      end

      def permitted_params
        params.require(:device).permit :token, :platform
      end

  end
end
