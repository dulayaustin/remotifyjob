class AddEmailAliasToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_alias, :string
    add_index :users, :email_alias
  end
end
