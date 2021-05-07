Rails.application.routes.draw do

  resources :home
  resources :produtos
  resources :movimentacaos
  resources :local_armazenamentos

  post "import", to: "home#import"

  post "up", to: "produtos#create"
  post "up2", to: "local_armazenamentos#create"

  post "upload", to: "movimentacaos#create"

  root "home#index"
end
