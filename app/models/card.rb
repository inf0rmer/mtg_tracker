class Card < ApplicationRecord
  validates :oracle_id, uniqueness: true, presence: true
  validates :name, presence: true
  validates :set, presence: true
end
