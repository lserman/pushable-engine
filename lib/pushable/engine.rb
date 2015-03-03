module Pushable
  class Engine < ::Rails::Engine
    isolate_namespace Pushable

    require 'responders'
    require 'mercurius'

  end
end
