class Servicio < ApplicationRecord
  has_many :detalle_contratos
  has_many :contratos, through: :detalle_contratos
end