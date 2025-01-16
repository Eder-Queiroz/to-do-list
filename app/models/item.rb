class Item < ApplicationRecord
  belongs_to :list

  validates :name, :status, presence: true # Valida que o nome e o status estão presentes.
end
