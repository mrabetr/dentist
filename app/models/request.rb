class Request < ApplicationRecord
  validates :mobile, format: { with: /\A(0|(\+|00)[1-9]\d{1,2}[\s-]?)[1-9]\d{8,}\z/, message: "bad format" }
end
