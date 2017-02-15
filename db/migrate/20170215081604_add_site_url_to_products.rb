class AddSiteUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :site_url, :text
  end
end
