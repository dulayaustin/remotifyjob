class AddLocationTypeAndSalaryBudgetToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :location_type, :string, null: false, default: "remote"
    add_column :jobs, :salary_budget, :string

    add_index :jobs, :location_type
  end
end
