class Cliente < ApplicationRecord
  has_many :eventos, dependent: :restrict_with_error
end
