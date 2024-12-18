require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should belong_to(:account) }
    it { should have_many(:sessions).dependent(:destroy) }
    it { should have_many(:emails).dependent(:destroy) }

    it { should accept_nested_attributes_for(:account) }
  end

  describe "validations" do
    context "for uniqueness of email address" do
      let!(:existing_user) { FactoryBot.create(:user, email_address: "test@example.com") }

      it { should validate_uniqueness_of(:email_address).case_insensitive }
    end
    it { should validate_presence_of(:email_address) }
    it { should allow_value("user@example.com").for(:email_address) }
    it { should_not allow_value("user.example").for(:email_address).with_message(/invalid/) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:password) }
  end

  describe "#email_alias" do
    context "generated upon after create callback" do
      let!(:user) { FactoryBot.create(:user) }

      it "is compose of email address prefix and user id that is concatenated by hyphen" do
        email_prefix = user.email_address.split("@").first

        expect(user.email_alias).to eq "#{email_prefix}-#{user.id}"
      end
    end
  end

  describe "#internal_email_address" do
    let!(:user) { FactoryBot.create(:user) }

    it "returns email format `reply-{user.email_alias}@remotifyjob.com` for sending emails" do
      expect(user.internal_email_address).to eq "reply-#{user.email_alias}@remotifyjob.com"
    end
  end
end
