Rails.application.routes.draw do

  resources :home
  resources :produtos
  resources :movimentacaos
  resources :local_armazenamentos

  post "import", to: "home#import"  #Método para importar arquivo CSV

  post "upload", to: "movimentacaos#create"   #Gerar movimentações a partir do arquivo CSV
  post "restore", to: "movimentacaos#delete"  #Método para limpar tabelas

  root "home#index"
end
