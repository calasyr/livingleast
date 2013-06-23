class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.integer :user_id
      t.integer :to_id
      t.text :message
      t.integer :purchase_id

      t.timestamps
    end
  end
end
