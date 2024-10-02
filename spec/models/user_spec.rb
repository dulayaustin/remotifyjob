require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "uniqueness of email address" do
      let!(:existing_user) { FactoryBot.create(:user, email_address: "test@example.com") }

      it { should validate_uniqueness_of(:email_address).case_insensitive }
    end
    it { should validate_presence_of(:email_address) }
    it { should allow_value("user@example.com").for(:email_address) }
    it { should_not allow_value("user.example").for(:email_address).with_message(/invalid/) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should accept_nested_attributes_for(:account) }

    context "matching of password and confirm password" do
      it "is valid when matched" do
        user = User.new(password: "password", confirm_password: "password")
        user.valid?

        expect(user.errors.full_messages).to_not include("Password does not match")
      end

      it "is invalid when mismatched" do
        user = User.new(password: "password", confirm_password: "incorrect_password")
        user.valid?

        expect(user.errors.full_messages).to include("Password does not match")
      end
    end
  end

  describe "associations" do
    it { should belong_to(:account) }
    it { should have_many(:sessions).dependent(:destroy) }
  end
end
