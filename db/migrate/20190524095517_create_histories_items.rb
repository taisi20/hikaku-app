class CreateHistoriesItems < ActiveRecord::Migration[5.2]
  def change
    create_table :histories_items do |t|
      t.references :history, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
