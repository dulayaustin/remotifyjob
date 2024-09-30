require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "create existing user" do
      let!(:existing_user) { FactoryBot.create(:user, email_address: "test@example.com") }

      it { should validate_uniqueness_of(:email_address).case_insensitive }
    end
    it { should validate_presence_of(:email_address) }
    it { should allow_value("user@example.com").for(:email_address) }
    it { should_not allow_value("user.example").for(:email_address).with_message(/invalid/) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "associations" do
    it { should belong_to(:account) }
    it { should have_many(:sessions).dependent(:destroy) }
  end
end
