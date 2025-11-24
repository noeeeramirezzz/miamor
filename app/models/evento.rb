class Evento < ApplicationRecord
  self.table_name = "eventos"

  belongs_to :cliente
  validate :duracion_minima

  has_many :contratos, dependent: :restrict_with_error

  has_many :asignaciones,
           class_name: "Asignacion",
           foreign_key: "evento_id",
           dependent: :restrict_with_error

  accepts_nested_attributes_for :asignaciones, allow_destroy: true

  def duracion_minima
    return if fecha_inicio.blank? || fecha_fin.blank?

    if fecha_fin < fecha_inicio + 1.hour
      errors.add(:fecha_fin, "debe ser al menos 1 hora mayor que la fecha de inicio")
    end
  end
end
