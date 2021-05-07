class ProdutosController < ApplicationController

    def index
        @produtos = Produto.all
    end

    def new
        @produto = Produto.new
    end

    def create
    end
end