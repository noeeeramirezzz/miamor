class Empleado < ApplicationRecord
  belongs_to :cargo

  before_save :asignar_salario_desde_cargo

  private

  def asignar_salario_desde_cargo
    self.salario = cargo.salario if cargo.present?
  end
  validates :categoria, presence: true

end
