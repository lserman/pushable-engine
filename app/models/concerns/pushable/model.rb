module Pushable
  module Model
    extend ActiveSupport::Concern

    included do
      has_many :devices, class_name: 'Pushable::Device', as: :pushable
    end

  end
end
