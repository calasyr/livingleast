class ChangeAccountIdInUsers < ActiveRecord::Migration
  def up
    change_column :users, :account_id, :string
  end

  def down
  end
end
