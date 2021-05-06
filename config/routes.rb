Rails.application.routes.draw do

  resources :home
  resources :produtos
  resources :movimentacaos
  resources :local_armazenamentos

  post "import", to: "home#import"

  post "upload", to: "home#create"

  root "home#index"
end
