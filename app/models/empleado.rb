class Empleado < ApplicationRecord
  self.table_name = "empleados"

  belongs_to :cargo
  has_many :asignacion_detalles, foreign_key: :empleado_id, dependent: :restrict_with_error

  before_save :asignar_salario_desde_cargo

  private

  def asignar_salario_desde_cargo
    self.salario = cargo.salario if cargo.present?
  end
end
