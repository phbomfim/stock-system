class Estoque < ApplicationRecord
  belongs_to :produto
  belongs_to :local_armazenamento
end
