class Member::OrdersController < ApplicationController
    # 注文情報入力画面
    def new
        @order = Order.new
        @adress = Address.all
    end
    # 注文情報入力確認画面
    def confirm
        @order = Order.new(order_params)
        # @orderはでかい箱で、その中に小さい箱を指定するためにストロングパラメーターを指定している。

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

        @cart_items = current_member.cart_items.all
        @order.member_id = current_member.id
    end

    # 注文情報保存
    #def create
        #@order = Order.new(order_params)
        #@order.member_id = current_member.id
        #@order.save
        #redirect_to thanx_orders_path
        # カート商品の情報を注文商品に移動
        #@cart_items = current_member.cart_items.all
        # @cart_items.each do |cart_item|
        #     OrderDetail.create(
        #       item:  cart_item.item,
        #       order:    @order,
        #       quantity: cart_item.quantity,
        #       subprice: sub_price(cart_item)
        #     )
        # end
        # # 注文完了後、カート商品を空にする
        # @cart_items.destroy_all
    #end

    def create
    @order = Order.new(order_params) #初期化代入
    @order.member_id = current_member.id #自身のidを代入
    @order.save #orderに保存
        #order_itmemの保存
        current_member.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
          @ordered_item = OrderedItem.new #初期化宣言
          @ordered_item.item_id = cart_item.item_id #商品idを注文商品idに代入
          @ordered_item.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
          @ordered_item.tax_included_price = (cart_item.item.price*1.08).floor #消費税込みに計算して代入
          @ordered_item.order_id =  @order.id #注文商品に注文idを紐付け
          @ordered_item.save #注文商品を保存
        end #ループ終わり

    current_member.cart_items.destroy_all #カートの中身を削除
    redirect_to thanx_orders_path #thanksに遷移

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
        #@ordered_items = @ordered.order_items
        # @order_details = @order.order_details
    end

    private
    def order_params
        params.require(:order).permit(:postage, :payment_method, :shipping_name, :shipping_address, :shipping_post_code ,:member_id,:total_payment,:status)
    end

end