class HomeController < ApplicationController
    ## Produto.find(ID) - Encontrar pela ID 
    ## @produto = Produto.find_or_create_by(nome: nome_produto) - Encontrar por termo
    ## Atualizar por termo se o produto existir
    ## @produto.update_attribute(:quantidade, @produto.quantidade +=1 ) if @produto.exist?

    def index
        @produtos = Produto.all
        @movimentacoes = Movimentacao.all
        @locais = LocalArmazenamento.all
    end

    def create
    end

    def import
        uploaded_io = params[:file]
        File.open(Rails.root.join(uploaded_io.original_filename), 'wb') do |file|
            if file.write(uploaded_io.read)
                redirect_to home_index_path
            end
        end
    end

    private


end