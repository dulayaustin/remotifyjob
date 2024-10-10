class CreateApplicants < ActiveRecord::Migration[8.0]
  def change
    create_table :applicants do |t|
      t.references :job, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :phone
      t.string :stage, null: false, default: "application"
      t.string :status, null: false, default: "active"

      t.timestamps
    end
    add_index :applicants, :email_address
    add_index :applicants, :stage
    add_index :applicants, :status
  end
end
