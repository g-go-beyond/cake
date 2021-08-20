class Member::CartItemsController < ApplicationController
    
    def index
        @cart_items = CartItem.all
        @numbers = [1,2,3,4,5,6,7,8,9]
    end
    
    # カート商品を追加・保存
    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.member_id = current_member.id
        if current_member.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
            cart_item = current_member.cart_items.find_by(item_id: params[:cart_item][:item_id])
            cart_item.quantity += params[:cart_item][:quantity].to_i
            cart_item.save
        elsif @cart_item.save
            @cart_items = CartItem.all
            render 'index'
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
        cart_items.destroy
        render 'index'
    end
    
    private

    def cart_item_params
        params.require(:cart_item).permit(:name, :price, :quantity)
    end
end
