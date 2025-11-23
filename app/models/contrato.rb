class Contrato < ApplicationRecord
  belongs_to :evento

  has_many :detalle_contratos, dependent: :destroy
  has_many :servicios, through: :detalle_contratos

  accepts_nested_attributes_for :detalle_contratos, allow_destroy: true
end

