Rails.application.routes.draw do
  resources :error_responses
  resources :success_responses
  resources :identifiers
  resources :users
  
  root 'identifiers#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
