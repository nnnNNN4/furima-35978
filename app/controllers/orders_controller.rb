class OrdersController < ApplicationController
before_action :authenticate_user!
before_action :set_item
before_action :sold_out
before_action :customer_confirmation

def index
  @order_address = OrderAddress.new
end

def create
  @order_address = OrderAddress.new(order_params)
  if @order_address.valid?
    pay_item
    @order_address.save
    return redirect_to root_path
  else
    render :index
  end
end

private

def order_params
  item = Item.find(params[:item_id])
  params.require(:order_address).permit(:postal_code, :shipped_area_id, :municipality, :address, :builing_name, :phone_number).merge(user_id: current_user.id, item_id: item.id, token: params[:token])
end

def set_item
  @item = Item.find(params[:item_id])
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp::Charge.create(
    amount: @item.price,  # 商品の値段
    card: order_params[:token],    # カードトークン
    currency: 'jpy'                 # 通貨の種類（日本円）
  )
end

def sold_out
  redirect_to root_path if @item.order.present?
end

def customer_confirmation
  redirect_to root_path if current_user.id == @item.user.id
end

end
