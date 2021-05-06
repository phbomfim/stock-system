class LocalArmazenamento < ApplicationRecord
    validates :nome, uniqueness: true
end
