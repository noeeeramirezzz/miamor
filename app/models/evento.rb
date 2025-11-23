class Evento < ApplicationRecord
  belongs_to :cliente
  validate :duracion_minima
  has_many :asignaciones, dependent: :destroy
  accepts_nested_attributes_for :asignaciones, allow_destroy: true
  def duracion_minima
    return if fecha_inicio.blank? || fecha_fin.blank?

    if fecha_fin < fecha_inicio + 1.hour
      errors.add(:fecha_fin, "debe ser al menos 1 hora mayor que la fecha de inicio")
    end
    end 
end
