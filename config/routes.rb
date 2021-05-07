Rails.application.routes.draw do
  namespace :api do
    resources :cards, :defaults => { :format => 'json' }
  end
end
