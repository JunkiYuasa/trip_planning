Rails.application.routes.draw do

  root :to =>"public/homes#top"  #TOPページ
  get "/about", to: "public/homes#about"  #ABOUTページ
  get "/admin", to: "admin/homes#top"  #カテゴリー、特徴ジャンル、特徴一覧（管理者用）
  
  #ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  #ゲストログイン用
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  scope module: :public do
    resources :users do
      resource :relationships, only: [:create, :destroy]
  	    get "followings", to: "relationships#followings", as: "followings"
  	    get "followers", to: "relationships#followers", as: "followers"
  	end
    resources :posts do
      get 'subject', on: :collection
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get "/search/subject", to: "searches#subject"
    get "/search/condition", to: "searches#condition"
    get "/search/result", to: "searches#result"
    
    get "followings_posts", to: "relationships#followings_posts"
    get "/favorite_posts", to: "favorites#favorite_posts"
  end
  
  
  namespace :admin do
    resources :categories
    resources :feature_genres
    resources :features
    resources :feature_purposes
  end
  
end
