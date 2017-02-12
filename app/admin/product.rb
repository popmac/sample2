ActiveAdmin.register Product do

  # N+1問題を解決
  controller do
    def scoped_collection
      Product.includes(:user)
    end
    def create
      @product = Product.new(params.require(:product).permit(:name, :url, :content).merge(user_id: current_user.id))
      url = @product.url
      agent = Mechanize.new
      page = agent.get("#{url}")
      element = page.at('head title')
      title = element.inner_text
      @product.title = title
      @product.save
      redirect_to admin_product_path(@product)
    end
  end

  # 登録されたデータ一覧が表示される画面をカスタマイズ
  index do
    selectable_column

    column :id do |product|
      link_to product.id, admin_product_path(product)
    end
    column :name
    column :url
    column :title
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
  permit_params :name, :url, :content, :user_id

  # Productのデータを登録するフォームをカスタマイズ
  form do |f|
    f.inputs do
      # user_idを選択できるようにしている
      f.input :user, :as => :select, :member_label => :id, :label => 'ユーザーID'
      f.input :name
      f.input :url
      f.input :content
    end
    f.actions
  end

end
