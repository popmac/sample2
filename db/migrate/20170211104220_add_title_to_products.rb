class AddTitleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :title, :text
  end
end
