class Member::OrdersController < ApplicationController
    # 注文情報入力画面
    def new
        @order = Order.new
        @adress = Address.all
    end
    # 注文情報入力確認画面
    def confirm
        @order = Order.new(order_params)
        
        # if文を記述して、hidden fieldが作動するようにする。
        # ご自身の住所と配送先住所が選択された場合はhiddenで処理
        
        # 現在memberに登録されている住所であれば
        # if params[:address_option] == "0"
        # @current_address = current_member.address
        # @current_last_name = current_customer.last_name
        # @current_first_name = current_customer.first_name
        
        # # # collection.selectであれば
        # elsif params[:address_option] == "1"
        # ship = ShippingAddress.find(params[:order][:shipping_address_id])
        # @order.postal_code = ship.postal_code
        # @order.address     = ship.address
        # @order.name        = ship.name
        
        # 新規住所入力であれば
        params[:address_option] = "2"
        @new_postage = @order.postage
        @new_address = @order.shipping_address
        @new_address = @order.shipping_name
    end
        
    # 注文情報保存
    def create
    end
    # ありがとうページ
    def thanx
    end
    # 注文情報履歴一覧
    def index
    end
    # 注文情報詳細 
    def show
    end
    
    private
    def order_params
        params.require(:order).permit(:postage, :payment_method, :shipping_name, :shipping_address, :shipping_post_code)
    end
end