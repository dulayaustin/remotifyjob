require 'rails_helper'

RSpec.describe Job, type: :model do
  pending "add closing_data:date column. Create a schedule cron job everyday to set status to `closed` when closing_date is present and today"
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:job_type) }
    it { should validate_presence_of(:location_type) }

    it { should have_rich_text(:description) }

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

    it do
      should define_enum_for(:location_type)
        .with_values(
          remote: 'remote',
          hybrid: 'hybrid',
          on_site: 'on_site'
        ).backed_by_column_of_type(:string)
    end
  end

  describe "associations" do
    it { should belong_to(:account) }
  end
end
