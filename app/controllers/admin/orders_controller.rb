class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
    # .page(params[:page]).per(10)
  end

  def show
     @order = Order.find(params[:id])
     @order_items = @order.ordered_items
    #  @order_items = @order.items
  end

  def update
    @order = Order.find(params[:id])
		@order.update(order_params)
		redirect_to admin_orders_path
  end

 private
 def order_params
  params.require(:order).permit(:status)
 end

end