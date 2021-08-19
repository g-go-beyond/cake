Rails.application.routes.draw do
    #devise_for :members
    #devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # 会員側のルーティング設定
  scope module: :member do
      resources :addresses, :except => [:new]  
      # resources :members,only: [:show,:edit,:update] do
      #   collection do
      #     get ’unsubscribe’
      #     patch ’withdraw’
      #   end
      # end
    resources :items,only: [:show,:index] do
      # collection do
      #   get ’top’
      #   get ’about’
      # end
    end

    resources :cart_items,only: [:index,:create,:update,:destroy] do
      # collection do
      #   delete ’all_destroy’
      # end
    end
    
    resources :orders,only: [:show,:edit,:update,:create] do
      # collection do
      # get ’thanx’
      # post ’confirm’
      # end
    end

  end
  devise_for :member,controllers: {
    sessions: 'members/sessions',
    registrations: 'members/registrations',
    passwords: 'members/passwords'}

# 管理者側のルーティング設定
  scope module: :admin do
    resources :members, :except => [:new,:destroy]
    resources :items, :except => [:destroy]
    resources :genres, :except => [:new,:show,:destroy]
    resources :orders,only: [:show,:update,:index]
    resources :ordered_items,only: [:update] 
  end
    
    devise_for :admin,controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations',
      passwords: 'admins/passwords'}
  
end
