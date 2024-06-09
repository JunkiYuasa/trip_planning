Rails.application.routes.draw do

  root :to =>"public/homes#top"  #TOPページ
  get "/about", to: "public/homes#about"  #ABOUTページ
  get "/admin", to: "admin/homes#top"  #カテゴリー、特徴ジャンル、特徴一覧（管理者用）
  
  #ユーザー用
  # URL /customers/sign_in
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  #管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  scope module: :public do
    resources :users
    resources :posts do
      get 'subject', on: :collection
    end
  end
  
  
  namespace :admin do
    resources :categories
    resources :feature_genres
    resources :features
    resources :feature_purposes
  end
  
end
