Rails.application.routes.draw do
  get '/', to: 'static_pages#index', as: :index

  post '/login',  to: 'sessions#create',  as: :login
  post '/logout', to: 'sessions#destroy', as: :logout

  get '/users/:id', to: 'users#show', as: :users_show

  get   '/users/:id/edit', to: 'users#edit', as: :users_edit
  patch '/users/:id/edit', to: 'users#update'
end
