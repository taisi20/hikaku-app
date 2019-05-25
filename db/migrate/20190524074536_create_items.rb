class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.json :response
      t.string :product_code
      t.string :shop

      t.timestamps
    end
  end
end
