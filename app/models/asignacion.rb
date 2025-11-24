class Asignacion < ApplicationRecord
  self.table_name = "asignaciones"
  belongs_to :evento

  has_many :asignacion_detalles, dependent: :destroy
  accepts_nested_attributes_for :asignacion_detalles, allow_destroy: true
end
