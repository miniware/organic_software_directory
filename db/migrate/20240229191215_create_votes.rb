class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # Add a unique index to enforce one vote per user per votable item
    add_index :votes, [:user_id, :votable_type, :votable_id], unique: true, name: "index_votes_on_user_and_votable_uniqueness"
  end
end
