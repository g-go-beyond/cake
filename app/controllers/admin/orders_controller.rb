class Admin::OrdersController < ApplicationController
    # 注文履歴一覧
    def index
        # このアクションを呼ぶ前のpathを取得
        @path = Rails.application.routes.recognize_path(request.referer)
        # 会員詳細から遷移した場合は、その顧客のみの注文履歴表示
        if @path[:controller] == "admin/members" && @path[:action] == "show"
           @order = Order.where(member_id: params[:format]).page(params[:page]).per(10)
        # ヘッダーから遷移した場合は、ログイン後は全顧客の注文履歴
        # elsif @path[:controller] == "admin/orders"
        #   @order = Order.where(created_at: Time.zone.today.all_day).page(params[:page]).per(10)
        else
           @order = Order.page(params[:page]).per(10)
        end
    end
    
    def show
        @order = Order.find(params[:id])
        # 注文内容の商品取得
        @ordered_items = @order.ordered_items
    end
    
    # 注文ステータスの更新
    def update
        @order = Order.find(params[:id]) # ステータスの更新ボタンが押された注文データの特定
        @ordered_items = @order.ordered_items # 注文商品から注文商品テーブルの呼び出し
        @order.update(order_params)# 注文ステータスの更新、更新するカラムはstatus
        # 紐づく注文ステータスが「入金確認」に更新されていたら
        if @order.status == "入金確認"
            # 制作ステータスを全ての商品に対して「製作待ち」に自動更新
            @ordered_items.update_all(making_status: "製作待ち")
        end
        redirect_to admin_order_path(@order)
    end

    private
    
    def order_params
        params.require(:order).permit(:status)
    end

end