class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :delivered, :canceled]
  before_action :check_user, only: [:show, :edit, :update, :delivered, :canceled]

  def index
    @orders = current_user.orders
  end

  def show; end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso!'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all

      flash.now[:alert] = 'Pedido não registrado.'
      render :new
    end
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso!'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all

      flash.now[:alert] = 'Pedido não atualizado'
      render :edit
    end
  end

  def search
    @query = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@query}%")
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def check_user
    return redirect_to root_path, alert: 'Você não possui acesso a esse pedido.' unless @order.user == current_user
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end