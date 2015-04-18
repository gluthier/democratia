Rails.application.routes.draw do

  root 'welcome#index'

  get '/cantons/:name/users' => 'cantons#users_in_cantons'

end
