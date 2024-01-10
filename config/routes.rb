Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  # 告訴他，我有自己客製化的，不要用內建預設的
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :stories
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # /@[username]/[title]
  get "@:username/:story_id", to: "pages#show", as: "story_page"

  # /@[username]/   當網址只有作者名稱的時候，跑出該作者所有文章
  get "@:username", to: "pages#user", as: "user_page"

  get "/demo", to:"pages#demo"

  # Defines the root path route ("/")
  root "pages#index"

end
