class Produto < ApplicationRecord
    validates :nome, uniqueness: true

    def self.assign_from_row(row)
        produto = Produto.new(name: produto_nome[1]).first_or_initalize
        user.assign_attributes row.to_hash.slice(:nome)
    end
end
