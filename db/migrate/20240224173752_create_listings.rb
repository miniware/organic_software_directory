class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :link
      t.string :icon
      t.string :cover
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
