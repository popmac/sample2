class AddPictureUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :picture_url, :text
  end
end
