Rails.application.routes.draw do
  root to: 'home#show'

  get '/start/:group', to: 'home#show' # Assign the group directly, otherwise a random one will be choosen

  resources :subjects do
    resource :pana_validation_questionary
  end

  get '/export', to: 'export#show'

  mount Ahoy::Engine => '/ahoy', as: :my_ahoy
end
