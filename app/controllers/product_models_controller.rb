class ProductModelsController < ApplicationController
  before_action :set_product_model, only: [:show]

  def index
    @product_models = ProductModel.all
  end

  def show; end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso!'
    else
      @suppliers = Supplier.all
      flash.now[:alert] = 'Modelo de produto não cadastrado.'
      render :new
    end
  end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def product_model_params
    params.require(:product_model).permit(:name, :height, :width, :depth, :weight, :sku, :supplier_id)
  end
end