class List < ApplicationRecord
    has_many :items, dependent: :destroy # Uma lista tem muitos itens e exclui os itens ao ser excluída.
    validates :name, presence: true # Valida que o nome da lista está presente.
end
