Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "public/registrations",
  }

  # ref: https://qiita.com/ryosuketter/items/9240d8c2561b5989f049
  scope module: :public do
    get 'mypage', to: "users#mypage"
    patch 'mypage', to: "users#update"
    resources :users, only: [:show, :destroy]
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
    resources :groups, only: [:index, :new, :show, :create, :edit, :update] do
      resources :group_users, only: [:index, :create, :destroy]
    end
    get "search" => "searches#search"
  end


  scope module: :admins do
    resources :users, only: [:index, :edit, :update]
    resources :groups, only: [:edit,:update, :destroy]
    resources :posts, only: [:index,:show, :destroy]
    get 'comments/destroy'
  end

    root to: 'public/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htmlend
end