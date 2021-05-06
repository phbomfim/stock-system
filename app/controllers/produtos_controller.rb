class ProdutosController < ApplicationController

    def index
        @produtos = Produto.all
    end

    def new
        @produto = Produto.new
    end

    def create
        contador = 0
        CSV.foreach("movimentacao_de_estoque.csv", headers: true , header_converters: :symbol) do |row| 
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
             if tipo_de_movimentacao[1] == " E"
                ## Verifica se o produto existe, caso não, cria

                @produto = Produto.find_or_create_by(nome: nome_produto[1])

                if @produto.save
                    contador += 1
                else  
                    redirect_to produtos_url and return
                end
            end
        end

        puts contador
        redirect_to home_index_path

    end
end