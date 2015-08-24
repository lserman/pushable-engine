module Pushable
  class Device < ActiveRecord::Base
    belongs_to :pushable, polymorphic: true
    validates :token, presence: true, uniqueness: { scope: :pushable }

    before_save :reset_token_expiry

    def reset_token_expiry
      self.token_expires_at = Time.current + expire_token_in
    end

    def expire_token_in
      14.days
    end

    def token_expired?
      token_expires_at.nil? || token_expires_at.past?
    end
  end
end
