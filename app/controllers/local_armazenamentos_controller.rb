class LocalArmazenamentosController < ApplicationController

    def index
        @locais = LocalArmazenamento.all
    end

    def new
        @local = LocalArmazenamento.new
    end

    def create
    end
end