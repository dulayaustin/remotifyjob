require 'rails_helper'

RSpec.describe Job, type: :model do
  describe "validations" do
    it { should validate_presence_of(:account_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:job_type) }

    it do
      should define_enum_for(:status)
        .with_values(
          draft: "draft",
          open: "open",
          closed: "closed"
        )
        .backed_by_column_of_type(:string)
    end

    it do
      should define_enum_for(:job_type)
        .with_values(
          full_time: "full_time",
          part_time: "part_time",
          contract: "contract",
          internship: "internship"
        ).backed_by_column_of_type(:string)
    end
  end

  describe "associations" do
    it { should belong_to(:account) }
  end
end
