module Pushable
  class ConsolesController < ::ActionController::Base
    layout 'pushable/application'

    def show
      @push = Pushable::ConsolePush.new
      @stubs = Pushable::Console.stubs
      @klasses = @stubs.map(&:klass)
    end

    def push
      @push = Pushable::ConsolePush.new permitted_params
      if @push.valid? && @push.deliver
        flash[:notice] = "Push delivered (sent to #{@push.sent_count} recipient(s))."
      else
        flash[:alert] = "Push failed! #{@push.errors.full_messages.to_sentence}."
      end
      show
      render :show
    end

    private

      def permitted_params
        klass = params[:console_push][:klass]
        params[:console_push].slice(:device_token, :klass).merge (params[:console_push][klass] || {})
      end

  end
end
