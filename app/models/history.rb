class History < ApplicationRecord
  validates :name, precence: true, length: { maximum: 15 }
  has_many :histries_items
  has_many :searched_items, through: :histries_items, source: :item
end
