class Member::ItemsController < ApplicationController
 before_action :authenticate_member!, only: [:show]

 def top
  @items = Item.all.order(created_at: :desc).limit(4)
 end
 
 def about
 end
 
 def index
  @items = Item.all.order(created_at: :desc)
 end
 
 def show
  @item = Item.find(params[:id])
  @cart_item =CartItem
 end

 private
 def item_params
  params.require(:items).permit(:genre_id,:name,:description,:image_id,:price)
 end
 
end
