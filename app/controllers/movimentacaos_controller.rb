class MovimentacaosController < ApplicationController

    def index
        @movimentacaos = Movimentacao.all
    end

    def new
        @movimentacao = Movimentacao.new
    end

    def create
        contador = 0
        CSV.foreach("movimentacao_de_estoque.csv", headers: true , header_converters: :symbol) do |row| 
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
            if tipo_de_movimentacao[1] == " E"
        
                ## Verifica se o produto/local existe, caso não, cria

                @produto = Produto.find_or_create_by(nome: nome_produto[1])
                @local = LocalArmazenamento.find_or_create_by(nome: nome_deposito[1])

                ## Verifica se ambas criações/verificações estão presentes

                if @produto.present? && @local.present?
                    @estoque = Estoque.find_by(produto_id: @produto.id, local_armazenamento_id: @local.id)
                    # Se o registro desse deposito/produto já existir, incrementa quantidade
                    if @estoque.present?
                        @estoque.update_attribute(:quantidade, @estoque.quantidade += quantidade[1].to_f)
                        contador += 1
                    # Se não realiza um novo registro no estoque
                    else  
                        @estoque = Estoque.new(produto_id: @produto.id, local_armazenamento_id: @local.id, quantidade: quantidade[1].to_f)
                        if @estoque.save
                            contador += 1
                        end
                    end
                end

                ## Registra a movimentação

                @movimentacao = Movimentacao.new(data: data[1].to_date,tipo: tipo_de_movimentacao[1], quantidade: quantidade[1].to_f,produto_id: Produto.find(@produto.id).id,local_armazenamento_id: LocalArmazenamento.find(@local.id).id)

                if @movimentacao.save
                    contador += 1
                end
            else
                redirect_to home_index_path  and return
            end
        end
    end
end