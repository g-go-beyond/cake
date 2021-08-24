class Admin::OrderedItemsController < ApplicationController
  #制作ステータス
  def update
		@ordered_item = OrderedItem.find(params[:id]) #　特定
		@order = @ordered_item.order 　　　　#注文商品から注文テーブル探す(外部key:oerdered_idがある)
		@ordered_item.update(ordered_item_params) #making_statusの更新
	

		if @ordered_item.making_status == "製作中" #製作ステータスが「製作作中」なら
			 @order.update(making_status: 2)         #注文ステータスを「製作中」　に更新

		elsif #注文商品(各項目?)の数=制作完了の数が同じ
		  @order.ordered_item.count ==  @order.ordered_item.where(making_status: "製作完了").count
			@order.update(order_status: 3) #注文ステータス「発送準備中]に更新
		end
		redirect_to admin_order_path(@ordered_item.order) #注文詳細に遷移
  end

   private
	  def ordered_item_params
      params.require(:ordered_item).permit(:making_status)
    end

end
