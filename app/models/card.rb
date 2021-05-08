class Card < ApplicationRecord
  self.primary_key = "id"

  validates :oracle_id, uniqueness: true, presence: true
  validates :name, presence: true
  validates :set, presence: true
end
