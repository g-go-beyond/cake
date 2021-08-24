class Member::OrdersController < ApplicationController
    # 注文情報入力画面
    def new
        @order = Order.new
        @adress = Address.all
    end
    # 注文情報入力確認画面
    def confirm
        @order = Order.new(order_params)
        # @orderはでかい箱で、その中に小さい箱を指定するためにストロングパラメーターを指定している.
        
        
        # if文を記述して、hidden fieldが作動するようにする。
        # ご自身の住所と配送先住所が選択された場合はhiddenで処理
        
        # 現在memberに登録されている住所であれば
        if params[:order][:address_option] == "0"
        @order.shipping_post_code = current_member.post_code
        @order.shipping_address = current_member.address
        @order.shipping_name = current_member.last_name + current_member.first_name 
        
        # collection.selectであれば
        elsif params[:order][:address_option] == "1"
        ship = Address.find(params[:order][:member_id])
        @order.shipping_post_code = ship.post_code
        @order.shipping_address = ship.address
        @order.shipping_name = ship.name 
        
        # 新規住所入力であれば
        elsif params[:order][:address_option] = "2"
        @order.shipping_post_code = params[:order][:shipping_post_code]
        @order.shipping_address = params[:order][:shipping_address]
        @order.shipping_name = params[:order][:shipping_name]
        else
            render 'new'
        end
        
        @cart_item = cart_item.all
    end
        
    # 注文情報保存
    def create
        @order = Order.new(order_params)
        @order.member_id = current_member.id
        @order.save
        redirect_to thanx_orders_path
    end
    # ありがとうページ
    def thanx
    end
    
    # 注文情報履歴一覧
    def index
        @orders = current_member.orders
    end
    # 注文情報詳細 
    def show
        @order = Order.find(params[:id])
    end
    
    private
    def order_params
        params.require(:order).permit(:postage, :payment_method, :shipping_name, :shipping_address, :shipping_post_code ,:member_id)
    end
    
end