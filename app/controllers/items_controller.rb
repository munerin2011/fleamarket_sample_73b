class ItemsController < ApplicationController
  before_action :set_parents, only: [:index, :new, :create]
  before_action :set_item, only: [:show, :purchase, :pay, :card_show]
  before_action :set_card, only: [:purchase, :pay, :card_show]

  def index
    @items = Item.includes(:item_imgs).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    @brands = Brand.all
  end

  def create
    @item = Item.new(item_params)
    @item.trading_status = 0
    @item.seller_id = current_user.id
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  # 商品出品ページのカテゴリー選択における、選択した親IDに該当する子IDの検索
  def search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds =Category.find(params[:children_id]).children
        end
      end
    end
  end

  def show
  end
  
  def purchase
    # 自分の出品物の購入ページには遷移しない
    redirect_to root_path if not user_signed_in?
    redirect_to root_path if @item.seller_id == current_user.id

    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    if not @card.blank?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => @card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
    )
    @item.trading_status = 1
    @item.buyer_id = current_user.id
    @item.save
    redirect_to action: :done
  end

  def done
  end

  def card_show
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def set_item
    @item = Item.find_by(id:params[:id])
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  private
  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def item_params
    params.require(:item).permit(
      :name,            :introduction,              :category_id, 
      :brand_id,        :item_condition_id,         :postage_payer_id,
      :prefecture_code, :preparation_day_id,        :postage_type_id,
      :price,           item_imgs_attributes:[:url]
    )
  end
end