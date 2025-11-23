class Cargo < ApplicationRecord
  has_many :empleados

  validates :nombre, presence: true
  validates :salario, numericality: { greater_than_or_equal_to: 0 }
end
