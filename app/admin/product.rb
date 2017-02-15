ActiveAdmin.register Product do

  # N+1問題を解決
  controller do
    def scoped_collection
      Product.includes(:user)
    end
    def create
      @product = Product.new(create_product_params)
      url = @product.site_url
      # title = get_url_title(url)
      get_url_title_by_capybara(url)
      @product.save
      flash[:notice] = 'titleが正しいか確認してください'
      # createしたらすぐにeditにリダイレクトさせる
      redirect_to edit_admin_product_path(@product)
    end
    private
    def create_product_params
      params.require(:product).permit(:name, :site_url, :content, :image).merge(user_id: current_user.id)
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
      @product.title = session.find('head title').text
      description = session.find('meta[name="description"]')
      @product.content = description['content']
      session.driver.quit
      Capybara.reset_sessions!
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
    column :site_url
    column :title
    column :content
    column :image do |product|
      image_tag product.image
    end
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
  permit_params :name, :site_url, :title, :content, :image, :user_id

  # Productのデータを登録するフォームをカスタマイズ
  form do |f|
    f.inputs do
      # user_idを選択できるようにしている
      f.input :user, :as => :select, :member_label => :id, :label => 'ユーザーID'
      f.input :name
      f.input :site_url
      f.input :title
      f.input :content
      f.input :image
    end
    f.actions
  end

end
