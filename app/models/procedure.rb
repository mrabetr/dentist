class Procedure < ApplicationRecord
  belongs_to :treatment

  monetize :price_cents
end
