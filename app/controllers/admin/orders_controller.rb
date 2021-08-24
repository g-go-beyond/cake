class Admin::OrdersController < ApplicationController
 before_action :authenticate_admin!
 #admin側のadmin
  def index
    @order = Order.all #.page(params[:page]).per(10)
  end

  def show
     @order = Order.find(params[:id])
     @ordered_items = @order.ordered_items
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path
  end
#admin側のadmin
 private
 def order_params #admin側で必要なのはsutesusだけ
  params.require(:order).permit(:status)
 end

end

