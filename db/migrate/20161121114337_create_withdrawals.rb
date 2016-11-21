class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.boolean :impression_unuseful, default: false, null: false
      t.boolean :impression_difficult, default: false, null: false
      t.boolean :impression_not_enough, default: false, null: false
      t.timestamps null: false
    end
  end
end
