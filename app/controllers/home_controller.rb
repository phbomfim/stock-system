class HomeController < ApplicationController

    def index
        @produtos = Product.all
        @locais = LocalArmazenamento.all
        @movimentacoes = Movimentacoes.all
    end

    def show
    end

end
