class ProductsController < ApplicationController
  def index
    if params[:category].blank?
      @products = Product.where(:is_hidden => false)
    else
      @category = Category.find_by(id: params[:category]) #找出是哪个category
      @products = Product.where(:category => @category) #找出这个category下的Job
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def welcome_show
    @products = Product.where(:is_hidden => false)
  end 

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
    redirect_to product_path
  end

  private

  def product_params
    params.require(:product).permit(:is_hidden)
  end
end
