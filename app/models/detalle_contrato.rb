class DetalleContrato < ApplicationRecord
  belongs_to :contrato
  belongs_to :servicio
end