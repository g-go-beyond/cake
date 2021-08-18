Rails.application.routes.draw do
    #devise_for :members
    #devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # 会員側のルーティング設定
  namespace :member do
    resources :members
  
  #get 'items' => 'member/items#index'
  #get 'items/:id' => 'member/items#show'

  #get 'members/:id' => 'member/members#show'
  #get 'members/:id/edit' => 'member/members#edit'

  #get 'orders' => 'member/orders#index'
  #get 'orders/:id' => 'member/orders#show'
  devise_for :member,controllers: {
      sessions: 'members/sessions',
      registrations: 'members/registrations',
      passwords: 'members/passwords'}
  end
# 管理者側のルーティング設定
  namespace :admin do
    resources :members
    resources :items
    resources :genres
  
    #get 'items' => 'admin/items#index' #view作ってから
    #get 'items/:id' => 'admin/items#show'

    #get 'members/:id' => 'admin/items#show'
    #get 'members/:id/edit' => 'admin/items#edit'

    #get 'orders' => 'admin/items#index'
    #get 'orders/:id' => 'admin/items#show'

    devise_for :admin,controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations',
      passwords: 'admins/passwords'}
  end
end
