class Item < ApplicationRecord
  belongs_to :list

  enum :status, %i[pending progress done] # Define os possíveis valores para o status.

  validates :name, presence: true # Valida que o nome e o status estão presentes.
end
