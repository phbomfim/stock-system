class HomeController < ApplicationController

    def index
        @produtos = Produto.all
        @movimentacoes = Movimentacao.all
        @locais = LocalArmazenamento.all
        @estoques = Estoque.all.order("local_armazenamento_id")
    end

    def create
    end

    ## Realizar a importanção do arquivo para o sistema
    def import
        uploaded_io = params[:file]
        File.open(Rails.root.join(uploaded_io.original_filename), 'wb') do |file|
            if file.write(uploaded_io.read)
                redirect_to movimentacaos_path
            end
        end
    end

    private


end