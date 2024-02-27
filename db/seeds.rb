# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.find_or_create_by(email: "nick@miniware.team") do |user|
  user.handle = "nickisnoble"
end

Listing.find_or_create_by(link: "https://rubyonrails.org/") do |listing|
  listing.user = User.first
end