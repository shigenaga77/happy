Rails.application.routes.draw do
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    # urlに:idを入れないためにresourcesではなくresource
    resource :members, only: [:show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :create, :destroy]
    # 退会確認画面
    get '/members/confirm' => 'members#confirm', as: 'confirm'
    # 論理削除用のルーティング
    patch '/members/withdraw' => 'members#withdraw', as: 'withdraw'
    # いいね一覧画面
    get '/members/likes' => 'members#likes', as: 'likes'
    # 下書き一覧画面
    get '/posts/drafts' => 'posts#drafts', as: 'drafts'
  end
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
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
