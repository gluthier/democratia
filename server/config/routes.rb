Rails.application.routes.draw do

  root 'welcome#index'

  get '/cantons' => 'cantons#list'
  get '/districts' => 'districts#list'
  get '/municipalities' => 'municipalities#list'

  get '/cantons/:name/users' => 'cantons#users_in_canton'
  get '/districts/:name/users' => 'districts#users_in_district'
  get '/municipalities/:name/users' => 'municipalities#users_in_municipality'

end
