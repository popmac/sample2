ActiveAdmin.register Product do

  # N+1問題を解決
  controller do
    def scoped_collection
      Product.includes(:user)
    end
    def create
      @product = Product.new(product_params)
      url = @product.url
      title = get_url_title_by_capybara(url)
      @product.title = title
      @product.save
      redirect_to admin_product_path(@product)
    end
    private
    def product_params
      params.require(:product).permit(:name, :url, :content).merge(user_id: current_user.id)
    end
    def get_url_title(url)
      agent = Mechanize.new
      page = agent.get("#{url}")
      element = page.at('head title')
      title = element.inner_text
      return title
    end
    def get_url_title_by_capybara(url)
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 })
      end
      Capybara.ignore_hidden_elements = false
      session = Capybara::Session.new(:poltergeist)
      session.visit "#{url}"
      session.find('head title').text
      # 一番最初に出てきたh1のtextを取得
      # session.first('h1').text
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
