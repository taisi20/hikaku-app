class AddColumnToDevelopers < ActiveRecord::Migration[5.2]
  def change
    add_column :developers, :name, :string
    add_column :developers, :email, :string
    add_column :developers, :password_digest, :string
  end
end
