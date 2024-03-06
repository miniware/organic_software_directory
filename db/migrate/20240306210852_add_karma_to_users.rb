class AddKarmaToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :karma, :integer, default: 0, null: false

    User.find_each do |user|
      listings_karma = user.listings.joins(:votes).count
      comments_karma = user.comments.joins(:votes).count
      user.update_column(:karma, listings_karma + comments_karma)
    end
  end
end
