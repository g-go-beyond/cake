class Admin::OrderedItemsController < ApplicationController
  before_action :authenticate_admin!

	def update
        # making_status => 制作ステータス(OrderedItemsモデルのカラム)
        # status        => 注文ステータス(Orderモデルのカラム)
		@ordered_item = OrderedItem.find(params[:id]) # 制作ステータスの変更ボタンどれ押されたか特定
		@order = @ordered_item.order # 注文商品から注文テーブルの呼び出し（何度も呼び出すのは処理が増える為）
		@ordered_item.update(ordered_item_params) # 製作ステータスの更新にはmaking_statusのデータ取得を必要と定義
		# 紐づく商品の制作ステータスがひとつでも「製作中」になったら
		if @ordered_item.making_status == "製作中"
		    # 注文ステータスを「製作中」に"自動更新"
			@order.update(status: "製作中")
	    
    	# 上記の条件に当てはまらなければ、商品の個数の特定　　　　製作ステータスが「製作終了」の商品をカウント
    	# 数が一致すれば、全ての商品の製作ステータスが「製作終了」だとわかる
    	# 前提の補足: パティシエは商品が制作終了するたびにその商品のmaking_statusを3に"手動更新"していく
		elsif @order.ordered_items.count ==  @order.ordered_items.where(making_status: "製作終了").count
			@order.update(status: "発送準備中") #注文ステータスを「発送準備中」に"自動更新"
		end
		redirect_to admin_order_path(@ordered_item.order) #注文詳細に遷移
	end
	
	private

    def ordered_item_params
        params.require(:ordered_item).permit(:making_status)
    end
end
