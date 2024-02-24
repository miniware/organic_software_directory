class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :handle
      t.text :bio

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :handle, unique: true
  end
end
