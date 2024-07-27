Rails.application.routes.draw do

  root :to =>"public/homes#top"  # TOPページ
  get "/about", to: "public/homes#about"  # ABOUTページ
  get "/admin", to: "admin/homes#top"  # カテゴリー、特徴ジャンル、特徴一覧（管理者用）

  # ユーザーログイン
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 管理者ログイン
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # メイン
  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
  	    get "followings", to: "relationships#followings", as: "followings"
  	    get "followers", to: "relationships#followers", as: "followers"
  	end
  	get "/user/:id/withdrawal", to: "users#withdrawal", as: "withdrawal"

    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      get 'subject', on: :collection
      get "not_exist", on: :collection
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get "/followings_posts", to: "relationships#followings_posts"
    get "/favorite_posts", to: "favorites#favorite_posts"

    resources :plans
    get '/plans', to: 'plans#index', defaults: { format: 'json' }

    resources :plan_genres, only: [:new, :index, :edit, :create, :update, :destroy]

    get "/search/subject", to: "searches#subject"
    get "/search/condition", to: "searches#condition"
    get "/search/result", to: "searches#result"
  end

  # 管理者用ページ
  namespace :admin do
    resources :categories
    resources :feature_genres
    resources :features
    resources :feature_purposes
  end

end
