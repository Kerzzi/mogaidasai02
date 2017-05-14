class Admin::ProductImagesController < Admin::BaseController

  before_action :find_product

  def index
    @product_images = @product.product_images
  end

  def create
    params[:images].each do |image|
      @product.product_images << ProductImage.new(image: image)
    end

    redirect_to :back
  end

  def destroy
    #养成习惯，所以子属性，都要从它的父类进行查找，所以这里没有直接使用ProductImage查找
    #而是使用product_images.find(params[:id])，这样就不会出现问题了
    @product_image = @product.product_images.find(params[:id])
    if @product_image.destroy
      flash[:notice] = "删除成功"
    else
      flash[:notice] = "删除失败"
    end

    redirect_to :back
  end

  def update
    # 取得当前的图片
    @product_image = @product.product_images.find(params[:id])
    #取得当前图片的权重
    @product_image.weight = params[:weight]
    if @product_image.save
      flash[:notice] = "修改成功"
    else
      flash[:notice] = "修改失败"
    end

    redirect_to :back
  end

  private
  def find_product
    @product = Product.find params[:product_id]
  end

end
