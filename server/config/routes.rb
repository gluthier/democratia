Rails.application.routes.draw do

  root 'index#index'

  get '/users/:id' => 'users#messages'
  get '/cantons' => 'cantons#list'
  get '/districts' => 'districts#list'
  get '/municipalities' => 'municipalities#list'

  get '/cantons/:name/users' => 'cantons#users_in_canton'
  get '/districts/:name/users' => 'districts#users_in_district'
  get '/municipalities/:name/users' => 'municipalities#users_in_municipality'

  get '/comments/:user_id' => 'comments#comments_for_user'

  get '/party/:name/users' => 'political_parties#political_party_users'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  post '/comments/create' => 'comments#create'
end
