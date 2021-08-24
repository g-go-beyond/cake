class Admin::ItemsController < ApplicationController
  # before_action :move_to_index, except: [:index, :show]
  
  # 商品一覧
  def index
    @items = Item.all
  end
  
  # 商品詳細
  def show
    @item = Item.find(params[:id])
  end
  
  # 商品新規登録
  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  # 商品登録処理
  def create
    @item = Item.new(item_params)
    if @item.save
      @items = Item.all
      render 'index'
    else
      @item = Item.new
      render 'new'
    end
  end
  
  # 商品編集
  def edit
    @item = Item.find(params[:id])
    #@genre = Genre.find(params[:id])
    @genres = Genre.all
  end
  
  # 商品更新
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "You have updated item successfully."
    else
      render "edit"
    end
  end
 
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :image, :price, :is_active)
  end
  
  
  
  # def move_to_index
  #   unless admin_admin_signed_in?
  #     redirect_to action: :index
  #   end
  # end
end
