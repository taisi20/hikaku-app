class Item < ApplicationRecord
  has_many :histories_items
  has_many :searched_keyword, through: :histories_items, source: :history
end
