class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :emails do |t|
      t.references :applicant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :subject
      t.string :email_type, default: "outbound"
      t.datetime :sent_at

      t.timestamps
    end
  end
end
