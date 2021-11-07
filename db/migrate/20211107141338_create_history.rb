class CreateHistory < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.integer :spot_id
      t.integer :user_id

      t.timestamps
    end
  end
end
