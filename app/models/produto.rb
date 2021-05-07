class Produto < ApplicationRecord
    validates :nome, length: {maximum: 20}, presence: true, uniqueness: true

end