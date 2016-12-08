ActiveAdmin.register Product do

  # N+1問題を解決
  controller do
    def scoped_collection
      Product.includes(:user)
    end
  end

  # 登録されたデータ一覧が表示される画面をカスタマイズ
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

  # 管理画面からProductのデータを登録できるようにする
  permit_params :name, :content, :user_id

  # Productのデータを登録するフォームをカスタマイズ
  form do |f|
    f.inputs do
      # user_idを選択できるようにしている
      f.input :user, :as => :select, :member_label => :id, :label => 'ユーザーID'
      f.input :name
      f.input :content
    end
    f.actions
  end

end
