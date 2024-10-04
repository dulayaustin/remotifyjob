require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should have_many(:users).dependent(:destroy) }
  end
end
