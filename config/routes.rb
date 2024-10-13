Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:edit, :update]
    resources :groups, only: [:edit,:update, :destroy]
    resources :posts, only: [:index,:show, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # ref: https://qiita.com/ryosuketter/items/9240d8c2561b5989f049
  scope module: :public do
    get 'mypage', to: "users#mypage"
    patch 'mypage', to: "users#update"
    resources :users, only: [:show, :destroy]
    resources :posts do
    resources :comments, only: [:create, :destroy]
    end
    resources :groups do
      resources :group_users, except: [:new, :edit]
      post '/change_join', to: 'groups#change_join', as: 'change_join'
      patch '/change_admin/:user_id', to: 'groups#change_admin', as: 'change_admin'
    end
    get "search" => "searches#search"
  end

    root to: 'public/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htmlend
end