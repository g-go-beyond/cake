class Member::CartItemsController < ApplicationController
      before_action :authenticate_member!

    def index
        @cart_items = current_member.cart_items.all
    end
    
    # カート商品を追加・保存
    def create
        @cart_item = current_member.cart_items.new(cart_item_params)
        # もしカート内にすでに商品が入っていた場合は数量を更新してから保存処理
        if current_member.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
            cart_item = current_member.cart_items.find_by(item_id: params[:cart_item][:item_id])
            cart_item.quantity += params[:cart_item][:quantity].to_i
            cart_item.save
            redirect_to cart_items_path
        # カート内にその商品が入っていなかった場合は通常の保存処理 
        elsif @cart_item.save
            @cart_items = current_member.cart_items.all
            render 'index'
        # 保存できなかった場合
        else
            render 'index'
        end
    end
    # カート商品を更新(数量の更新)
    def update
        @cart_item = CartItem.find(params[:id])
        @cart_item.update(cart_item_params)
        redirect_to cart_items_path(@cart_item.id)
    end
    
    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        @cart_items = CartItem.all
        render 'index'
    end
    
    def all_destroy
        cart_items = CartItem.all
        cart_items.destroy_all
        
        render 'index'
    end
    
    private

    def cart_item_params
        params.require(:cart_item).permit(:item_id, :price, :quantity)
    end
end
