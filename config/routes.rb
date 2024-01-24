Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  namespace :api do
  # 將相關的路徑放在一起，也可再加一層版本號
  # namespace :V2 do，這樣只要改路徑，整個版本號就可以直接更新
    resources :users, only: [] do
      member do
        post :follow
      end
    end

    post :upload_image, to: "utils#upload_image"

    resources :stories, only: [] do
      member do
        post :clap
        post :bookmark
      end
    end
  end
  resource :users, only: [] do
    collection do 
      get :pricing  # /users/pricing 
      get :payment  # /users/payment
    end
  end

  # 告訴他，我有自己客製化的，不要用內建預設的
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :stories do 
    resources :comments, only: [:create]

   
  end
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
