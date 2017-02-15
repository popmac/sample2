class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.joins(:user)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(create_product_params)
    @site_url = @product.site_url
    # @product.title = get_url_title(@site_url)
    # @product.title = get_url_title_by_capybara(@site_url)
    get_url_title_by_capybara(@site_url)

    if @product.save
      redirect_to edit_product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(update_product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def create_product_params
      # params.require(:product).permit(:name, :site_url, :content).merge(user_id: current_user.id)
      params.require(:product).permit(:name, :site_url, :image).merge(user_id: current_user.id)
    end

    def update_product_params
      params.require(:product).permit(:name, :site_url, :title, :content, :image).merge(user_id: current_user.id)
    end

    def get_url_title(url)
      agent = Mechanize.new
      page = agent.get("#{url}")
      element = page.at('head title')
      title = element.inner_text
      # 以下はdescriptionを取得する場合
      # node = page.at("head meta[name='description']")
      # description = node["content"]
    end

    def get_url_title_by_capybara(url)
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 })
      end
      Capybara.ignore_hidden_elements = false
      session = Capybara::Session.new(:poltergeist)
      session.visit "#{url}"
      title = session.find('head title').text
      @product.title = title
      tmp_description = session.all('meta[name="description"]')
      description = tmp_description[0]
      if description == nil
      else
        @product.content = description['content']
      end
      # img = session.first('img')
      # @product.picture_url = img['src']
      # 以下はfindを使うと例外のエラーが発生するためallを使っている
      tmp_og_image = session.all('meta[property="og:image"]')
      og_image = tmp_og_image[0]
      if og_image == nil
      else
        @product.picture_url = og_image['content']
      end
      session.driver.quit
      Capybara.reset_sessions!
      # 一番最初に出てきたh1のtextを取得
      # session.first('h1').text
    end
end
