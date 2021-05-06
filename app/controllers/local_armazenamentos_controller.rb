class LocalArmazenamentosController < ApplicationController

    def index
        @locais = LocalArmazenamento.all
    end

end