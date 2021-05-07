class Movimentacao < ApplicationRecord
  belongs_to :produto
  belongs_to :local_armazenamento

  validates :tipo, length: {maximum: 2}, presence: true
  validates :data, presence: true, 
            inclusion: {in: (Date.new(2021,01,01)..Date.new(2021,01,31)), message: "Fora do periodo"}
           
end