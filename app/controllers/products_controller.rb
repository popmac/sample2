class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.joins(:user)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @url = @product.url
    # @product.title = get_url_title(@url)
    @product.title = get_url_title_by_capybara(@url)

    if @product.save
      redirect_to edit_product_path(@product)
    else
      render :new
    end
  end

  # GET /products/1/edit
  def edit
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(edit_product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :url, :content).merge(user_id: current_user.id)
    end

    def edit_product_params
      params.require(:product).permit(:name, :url, :title, :content).merge(user_id: current_user.id)
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
      session.find('head title').text
      # 一番最初に出てきたh1のtextを取得
      # session.first('h1').text
    end
end
