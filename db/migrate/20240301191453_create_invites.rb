class CreateInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :invites do |t|
      t.references :sent_by, null: false, foreign_key: {to_table: :users}
      t.references :accepted_by, null: true, foreign_key: {to_table: :users}
      t.string :recipient_email

      t.timestamps
    end

    add_index :invites, :recipient_email, unique: true
  end
end
