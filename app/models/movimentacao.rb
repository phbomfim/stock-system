class Movimentacao < ApplicationRecord
  belongs_to :produto
  belongs_to :local_armazenamento

  validates :tipo, length: {maximum: 2}
end
