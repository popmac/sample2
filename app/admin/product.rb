ActiveAdmin.register Product do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  selectable_column

  column :id do |product|
    link_to product.id, admin_product_path(product)
  end
  column :name
  column :content
  column :user_id do |product|
    if product.user.present?
      link_to product.user.id, admin_user_path(product.user)
    else
      status_tag('Empty')
    end
  end
  column :created_at
  column :updated_at
  actions
end

permit_params :name, :content, :user_id

form do |f|
  f.inputs do
    f.input :user_id
    f.input :name
    f.input :content
  end
  f.actions
end

end
