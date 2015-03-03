Pushable::Engine.routes.draw do
  post 'consoles/push', to: 'consoles#push', as: :push
  root to: 'consoles#show'
end
