class AddIndexToHistriesItems < ActiveRecord::Migration[5.2]
  def change
    add_index :histories_items, [:history_id, :item_id], unique: true
  end
end
