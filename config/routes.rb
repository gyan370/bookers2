Rails.application.routes.draw do
  
  devise_for :users
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit]
  resources :users, only: [:index, :show, :edit, :update]
  patch 'books/:id' => 'books#update', as: 'update_book'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: "homes#top" 
get 'home/about', to: 'homes#about', as: 'about'
get '/books', to: 'books#index'
end

