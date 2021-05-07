class LocalArmazenamentosController < ApplicationController

    def index
        @locais = LocalArmazenamento.all
    end

    def new
        @local = LocalArmazenamento.new
    end

    def create
        contador = 0
        CSV.foreach("movimentacao_de_estoque.csv", headers: true , header_converters: :symbol) do |row| 
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
             if tipo_de_movimentacao[1] == " E"
                ## Verifica se o produto existe, caso não, cria

                @local = LocalArmazenamento.find_or_create_by(nome: nome_deposito[1])

                if @local.save
                    contador += 1
                else  
                    redirect_to local_armanezamentos_url and return
                end
            end
        end

        puts contador
        redirect_to home_index_path

    end
end