class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.default_sort
    "created_at-desc"
  end
end
