class AddDefaultToHistories < ActiveRecord::Migration[5.2]
  def change
    change_column :histories, :count, :integer, :default => 1
  end
end
