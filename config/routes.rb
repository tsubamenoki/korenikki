Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: 'homes#about'
  get 'top' => 'homes#top'
  get 'users/mypage' => 'users#show'
  get 'users/mypage/edit' => 'users#edit'
  patch 'users/mypage' => 'users#update'
  get 'users/mypage/confirm'=>"users#confirm"
  patch 'users/mypage/withdraw'=>"users#withdraw"

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end

  get "search_tag" => "posts#search_tag"

  get "search" => "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
