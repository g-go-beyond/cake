class Member::ItemsController < ApplicationController
 
 def top
  @items = Item.all.order(created_at: :desc).limit(4)
 end
 
 def about
 end
 
 def index
  @items = Item.all.order(created_at: :desc)
  # @ordered_items = OrderedItems.all
 end
 
 def show
  @item = Item.find(params[:id])
  @cart_item =CartItem
  # @ordered_items = OrderedItems.all
 end
 
 #def create
  #@item = Item.find(params[:id])
  #@cart_item = @item.user([item_id: item_id])
  #@cart_item.save
  #redirect_to cart_items
 #end
 
 private
 def item_params
  params.require(:items).permit(:genre_id,:name,:description,:image_id,:price)
 end
 
end
