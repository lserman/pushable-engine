Rails.application.routes.draw do

  mount Pushable::Engine => "/pushable"
  resources :devices

end
