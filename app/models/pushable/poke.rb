module Pushable
  class Poke < Message

    def alert
      'Hello from Pushable!'
    end

    def data
      { sent_at: Time.current.to_i }
    end

  end
end
