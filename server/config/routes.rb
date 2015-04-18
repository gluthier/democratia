Rails.application.routes.draw do

  root 'welcome#index'

  get '/cantons/:name/users' => 'cantons#users_in_canton'
  get '/districts/:name/users' => 'districts#users_in_district'
  get '/communes/:name/users' => 'communes#users_in_commune'

end
