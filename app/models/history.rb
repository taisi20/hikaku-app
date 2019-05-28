class History < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  has_many :histories_items
  has_many :searched_items, through: :histories_items, source: :item
end
