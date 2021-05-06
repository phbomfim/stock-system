class Produto < ApplicationRecord
    validates :nome, uniqueness: true

end