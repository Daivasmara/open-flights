class Review < ApplicationRecord
  validates :title, presence: true
  validates :score, presence: true
  validates :airline_id, presence: true

  belongs_to :airline
end
