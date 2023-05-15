Rails.application.routes.draw do
  # 顧客用
  # URL /members/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # ゲストログイン
  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # 会員側
  scope module: :public do 
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get '/members/confirm' => 'members#confirm', as: 'confirm'
    patch '/members/withdraw' => 'members#withdraw', as: 'withdraw'
    resources :members, only: [:show, :edit, :update]do
    # いいね一覧画面
      member do
        get :likes
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts do
      resources :posts, only: [:index, :show, :edit, :update, :create, :destroy]
      resources :comments, only: [:create, :destroy]
      collection do
        get 'search'
    # 下書き一覧画面
        get 'drafts'
      end
        # コメント一覧画面
        get 'comment_index'
    resource :favorites, only: [:create, :destroy]
    end
    # 退会確認画面
    # 論理削除用のルーティング
    # 通知機能
    resources :notifications, only: :index
    get 'favicon.ico'
  end
  
  namespace :admin do
    resources :members, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]do
      resources :comments, only: :destroy
    end
    resources :genres, only: [:index, :edit, :update, :create]
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
