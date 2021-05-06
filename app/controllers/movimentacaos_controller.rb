class MovimentacaosController < ApplicationController

    def index
    end

    def new
        @movimento = Movimentacao.new
    end

    def create
        contador = 0
        CSV.foreach("movimentacao_de_estoque.csv", headers: true , header_converters: :symbol) do |row| 
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
            ## Verifica se é uma movimentação de entrada
            if tipo_de_movimentacao == [tipo_de_movimentacao, " E"]
        
                ## Verifica se o produto/local existe, caso não, cria

                @produto = Produto.find_or_create_by(nome: nome_produto[1])
                @local = LocalArmazenamento.find_or_create_by(nome: nome_deposito[1])

                ## Verifica se ambas criações/verificações estão presentes

                if @produto.present? && @local.present?
                    @estoque = Estoque.find_by(produto_id: @produto.id, local_armazenamento_id: @local.id)
                    # Se o registro desse deposito/produto já existir, incrementa quantidade
                    if @estoque.present?
                        @estoque.update_attribute(:quantidade, @estoque.quantidade += quantidade[1])
                        contador += 1
                    # Se não realiza um novo registro no estoque
                    else  
                        @estoque = Estoque.new(produto_id: @produto.id, local_armazenamento_id: @local.id, quantidade: quantidade[1])
                        if @estoque.save
                            contador += 1
                        end
                    end
                end

                ## Registra a movimentação

                @movimento = Movimentacao.new(
                    data: data[1],
                    tipo: tipo_de_movimentacao[1], 
                    quantidade: quantidade[1],
                    produto_id: Produto.find(@prodto.id),
                    localarmazenamento_id: LocalArmazenamento.find(@local.id))

                if @movimento.save
                    contador += 1
                    redirect_to home_index_path
                end
            end
        end
    end
end