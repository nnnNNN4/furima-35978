Rails.application.routes.draw do
  devise_for :users

  #itemsコントローラについてのルーティング
  resources :items, only: [:index, :new, :create, :show]

  #usersコントローラに対してのルーティング

  #ユーザーが最初にたどり着くページ
  root to: "items#index"
end
