class AddSlugToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :slug, :string
    add_index :listings, :slug, unique: true

    Listing.find_each do |listing|
      listing.save(touch: false) # `touch: false` to avoid updating `updated_at`
    end
  end
end
