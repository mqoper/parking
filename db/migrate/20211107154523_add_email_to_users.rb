class AddEmailToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string
    add_column :users, :slack_register_id, :string
  end
end
