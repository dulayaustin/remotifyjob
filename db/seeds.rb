# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

account = Account.find_or_create_by!(name: "Sample Account")

user = User.find_by(email_address: "test@example.com")
User.create!(email_address: "test@example.com", account: account, first_name: "Test", last_name: "Example", password: "password") unless user.present?
