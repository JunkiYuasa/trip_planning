Rails.application.routes.draw do
  
  namespace :public do
    get 'users/show'
    get 'users/index'
    get 'users/edit'
  end
  root :to =>"public/homes#top"  #TOPページ
  get "/about" => "public/homes#about"  #ABOUTページ
  get "/admin" => "admin/homes#top"  #カテゴリー、特徴ジャンル、特徴一覧（管理者用）
  
  #ユーザー用
  # URL /customers/sign_in
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 退会処理
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  
  #管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  scope module: :public do
    resources :users
  end
  
  
  namespace :admin do
  end
  
end
