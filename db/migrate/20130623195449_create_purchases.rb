class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :merchant_name
      t.string :city
      t.decimal :amount
      t.string :category

      t.timestamps
    end
  end
end
