class MovimentacaosController < ApplicationController

    def index
        @movimentacaos = Movimentacao.all
    end

    def new
        @movimentacao = Movimentacao.new
    end

    def delete
        #Limpar tabelas de movimentacao e estoque, além de limpar arquivo do log
        @movimentacao = Movimentacao.destroy_all
        @estoque = Estoque.destroy_all
        File.truncate('log.txt', 0)

        redirect_to home_index_path 
    end

    def create
        contador = 0
        rows = []

        ## Adiciona valores no vetor transformando-os em hash
        CSV.foreach("movimentacao_de_estoque.csv", headers: true , header_converters: :symbol) do |row|
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
            rows << row.to_h.values
        end

        ## Ordenação pela segunda coluna(data) e em seguida pela terceira(tipo)
        rows.sort_by! { |row| row[1,2]}
            
        rows.each do |row|
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
            ## Verifica se o produto/local existe, caso não, cria
            @produto = Produto.find_or_create_by(nome: nome_produto)
            @local = LocalArmazenamento.find_or_create_by(nome: nome_deposito)

            ## Define criação de movimentacao para verificação
            @movimentacao = Movimentacao.new(data: data.to_date,tipo: tipo_de_movimentacao, quantidade: quantidade.to_f,produto_id: Produto.find(@produto.id).id,local_armazenamento_id: LocalArmazenamento.find(@local.id).id)
            
            if @movimentacao.valid?

                if @produto.valid? && @local.valid?

                    ## Primeiro caso = ENTRADA
                    if tipo_de_movimentacao == " E"

                        @estoque = Estoque.find_by(produto_id: @produto.id, local_armazenamento_id: @local.id)
                        # Se o registro desse deposito/produto já existir, incrementa quantidade
                        if @estoque.present?
                            @estoque.update_attribute(:quantidade, @estoque.quantidade += quantidade.to_f)
                            contador += 1
                        # Se não realiza um novo registro no estoque
                        else  
                            @estoque = Estoque.new(produto_id: @produto.id, local_armazenamento_id: @local.id, quantidade: quantidade.to_f)
                            if @estoque.save
                                contador += 1
                            else
                                if @estoque.valid? == false
                                    File.write("log.txt","Estoque erro: #{@estoque.errors.messages}", mode: "a")
                                    File.write("log.txt", "\n", mode: "a")
                                end
                            end
                        end

                    ## Segundo caso = SAIDA
                    elsif tipo_de_movimentacao == " S"

                        @estoque = Estoque.find_by(produto_id: @produto.id, local_armazenamento_id: @local.id)
                        # Se o registro desse deposito/produto já existir
                        if @estoque.present?
                            if @estoque.quantidade >= quantidade.to_f    #Verifica quantidade disponivel
                                @estoque.update_attribute(:quantidade, @estoque.quantidade -= quantidade.to_f)
                                contador += 1
                            else
                                File.write("log.txt", "Quantidade não suficiente para #{@produto.nome} no #{@local.nome}: têm #{@estoque.quantidade} - precisa #{quantidade.to_f} \n", mode: "a")
                                File.write("log.txt", "\n", mode: "a")
                            end
                        else
                            File.write("log.txt","Estoque não encontrado para retirada de #{@produto.nome} no #{@local.nome}", mode: "a")
                            File.write("log.txt", "\n", mode: "a")
                        end
                    end

                elsif @produto.valid? == false 
                    File.write("log.txt","Falha na movimentação - Produto erro : #{@produto.errors.messages}", mode: "a")
                    File.write("log.txt", "\n", mode: "a")
                else  
                    File.write("log.txt","Falha na movimentação - Depósito erro: #{@local.errors.messages}", mode: "a")
                    File.write("log.txt", "\n", mode: "a")
                end

                ## Registra a movimentação de SAIDA

                if @movimentacao.save
                    contador += 1
                end

            else
                File.write("log.txt","Movimentacao #{nome_deposito} - #{data} - #{tipo_de_movimentacao} - #{nome_produto} - #{quantidade} - erro reportado: #{@movimentacao.errors.messages}", mode: "a")
                File.write("log.txt", "\n", mode: "a")
            end
        end

        redirect_to home_index_path 
    end
end