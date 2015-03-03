module Pushable
  class Console

    def self.stubs
      @@stubs ||= []
    end

    def self.<<(stub)
      stubs << stub
    end

    def self.reset
      @@stubs = []
    end

  end
end
