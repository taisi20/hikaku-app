class History < ApplicationRecord
  validates :name, presence: true, length: { in: 2..15 }

  has_many :histories_items
  has_many :searched_items, through: :histories_items, source: :item
  
  def history_update(history)
    self.count = self.count + 1
    self.save
  end
end
