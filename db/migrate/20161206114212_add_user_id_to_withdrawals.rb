class AddUserIdToWithdrawals < ActiveRecord::Migration
  def change
    add_column :withdrawals, :user_id, :integer
  end
end
