class Payment < ApplicationRecord
  belongs_to :treatment

  monetize :amount_cents
end
