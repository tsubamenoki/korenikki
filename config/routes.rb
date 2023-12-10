Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root to: 'homes#top'
  get 'about' => 'homes#about'

  get 'users/mypage' => 'users#show'
  get 'users/mypage/edit' => 'users#edit'
  patch 'users/mypage' => 'users#update'
  get 'users/mypage/confirm'=>"users#confirm"
  patch 'users/mypage/withdraw'=>"users#withdraw"

  resources :posts


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
