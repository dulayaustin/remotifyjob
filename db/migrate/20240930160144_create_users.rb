class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.references :account, foreign_key: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end