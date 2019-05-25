class AddSearchedAtToHistoriesItems < ActiveRecord::Migration[5.2]
  def change
    add_column :histories_items, :searched_at, :timestamp
  end
end
