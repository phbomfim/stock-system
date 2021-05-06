class Movimentacao < ApplicationRecord
  belongs_to :produto
  belongs_to :local_armazenamento
end
