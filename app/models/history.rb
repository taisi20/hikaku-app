class History < ApplicationRecord
  #before_save { self.name.strip }
  validates :name, presence: true, length: { in: 2..15 }, history_name: true#, format: { with: /\A[[:space:]]*\z/ }
  has_many :histories_items
  has_many :searched_items, through: :histories_items, source: :item
  
  def history_update(history)
    self.count = self.count + 1
    self.save
  end
end