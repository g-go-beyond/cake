class Admin::OrdersController < ApplicationController
  def index
    @orders=Order.all.page(params[:page]).per(10)
  end

  def show
     @order = Order.find(params[:id])
     @order_item= @order.order_item
  end

  def update
    @order = Order.find(params[:id])
    @order.pudate(order_params)
    redirect_to admin_order_path
  end

 private
 def order_params
  params.require(:order).permit()
 end

end