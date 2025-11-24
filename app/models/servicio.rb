class Servicio < ApplicationRecord
  has_many :detalle_contratos,
           dependent: :restrict_with_error

  has_many :contratos, through: :detalle_contratos

  has_many :asignacion_detalles,
           foreign_key: :servicio_id,
           dependent: :restrict_with_error
end
