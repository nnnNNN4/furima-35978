class ItemsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_command, only: [:show, :edit, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  #privateメソッドで処理をまとめておく
  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :shipping_charge_id, :shipped_area_id, :day_to_shipped_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_command
    @item = Item.find(params[:id])
  end
end
