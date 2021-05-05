class Movimentacao < ApplicationRecord
  belongs_to :produto
  belongs_to :localarmazenamento
end
