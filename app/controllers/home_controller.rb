class HomeController < ApplicationController

    def index
        @produtos = Produto.all
        @movimentacoes = Movimentacao.all
        @locais = LocalArmazenamento.all
    end

    def create
        CSV.foreach("movimentacao_de_estoque.csv", headers: true , header_converters: :symbol) do |row| 
            nome_deposito, data, tipo_de_movimentacao, nome_produto, quantidade = row
            if (tipo_de_movimentacao == [tipo_de_movimentacao, "E"])
                @produto = Produto.new(nome: nome_produto[1])
                @local = LocalArmazenamento.new(nome: nome_deposito[1])

                if @produto.save
                    if @local.save
                        redirect_to home_path
                    else 
                        redirect_to armazenamento_locals_path
                    end
                else  
                    redirect_to produtos_path
                end

                #@movimento = Movimentacao.new(
                #    data: data[1], 
                #    tipo: tipo_de_movimentacao[1], 
                #    quantidade: quantidade[1],
                #    produto_id: Produto.last.id,
                #    localarmazenamento_id: LocalArmazenamento.last.id)
                puts "Importou #{contador} registros"
            else  
                puts "Nao tinha nada"
            end
        end
    end

    def import
        uploaded_io = params[:file]
        File.open(Rails.root.join(uploaded_io.original_filename), 'wb') do |file|
            if file.write(uploaded_io.read)
                redirect_to home_index_path
            end
        end
    end
end